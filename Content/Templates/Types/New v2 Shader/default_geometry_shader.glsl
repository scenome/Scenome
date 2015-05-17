#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Geometry.glsl>

uniform int geometryShellCount;
uniform float shellScaleFactor;

// Note: These must match enum Guides in ModelOpt.h!
#define G_FaceNormals 2
#define G_VertexNormals 128
#define G_Handles 1024
#define G_Tangents 4096
#define G_Vertices 8192
#define G_Edges 16384
#define G_HiddenEdges 32768

#define PointsPerLine 2
#define VertsPerTri 3
#define MaxShells 3
#define TangentsPerVert 2

// PointsPerLine * MaxShells
#define MaxPointsFaceNormalsGuide 6

// PointsPerLine * VertsPerTri * MaxShells
#define MaxPointsVertexNormalsGuide 18

// PointsPerLine * TangentsPerVert * VertsPerTri * MaxShells
#define MaxPointsVertexTangentsGuide 36

layout( triangles, invocations = 1 ) in;

in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut;

#if M_SPA_Guide == G_FaceNormals
   layout( line_strip, max_vertices = MaxPointsFaceNormalsGuide ) out;
#elif M_SPA_Guide == G_VertexNormals
   layout( line_strip, max_vertices = MaxPointsVertexNormalsGuide ) out;
#elif M_SPA_Guide == G_Tangents
   layout( line_strip, max_vertices = MaxPointsVertexTangentsGuide ) out;
#else
   layout( triangle_strip, max_vertices = 9 ) out;
#endif

// The various GenerateVertex functions prepare prepare the geometry program 
// stage outputs for emitting a vertex. The variations implement modeling 
// operations like basic rigid transformation, normal-offset shells, or 
// conversion from triangle to line to visualize surface tangent attributes,
// or combinations of these operations. EmitVertex may be used immediately 
// after a call to one of the functions.

// GenerateVertex prepares a pass-through vertex containing all attributes 
// from a source primitive vertex. 
void GenerateVertex( out vertexData destAttributes, in vertexData sourceAttributes )
{
   destAttributes = sourceAttributes;
   // reuse the final calculated output position for the final gl_Position transform
   gl_Position = view.modelViewProjectionMatrix * destAttributes.position;
}

// GenerateVertexV prepares a vertex containing all attributes from a source
// primitive vertex, with an arbitrary position.
void GenerateVertexV( out vertexData destAttributes, in vertexData sourceAttributes, in vec4 position )
{
   // Copy all attributes by default (the entire struct)
   destAttributes = sourceAttributes;
   destAttributes.position = position;
   destAttributes.positionViewspace = ( view.modelViewMatrix * position ).xyz;

   // reuse the final calculated output position for the final gl_Position transform
   gl_Position = view.modelViewProjectionMatrix * position;
}

// GenerateShellVertex prepares a vertex containing all attributes from a source
// primitive vertex, with a normal-offset shell position.
void GenerateShellVertex( out vertexData destAttributes, in vertexData sourceAttributes, float scale )
{
   GenerateVertexV( destAttributes, sourceAttributes, sourceAttributes.position + vec4( sourceAttributes.normal * scale, 0.0f ) );
}

// GenerateTangentVertex prepares a vertex containing all attributes from a source
// primitive vertex, offset from the vertex position by the tangent vector, 
// suitable for creating a tangent line guide.
void GenerateTangentVertex( out vertexData destAttributes, in vertexData sourceAttributes, float scale )
{
   GenerateVertexV( destAttributes, sourceAttributes, 
      sourceAttributes.position + vec4( sourceAttributes.normal * scale + sourceAttributes.tangent, 0.0f ) );
}

// GenerateBinormalVertex prepares a vertex containing all attributes from a source
// primitive vertex, offset from the vertex position by the binormal vector, 
// suitable for creating a binormal line guide.
void GenerateBinormalVertex( out vertexData destAttributes, in vertexData sourceAttributes, float scale )
{
   GenerateVertexV( destAttributes, sourceAttributes, 
      sourceAttributes.position + vec4( sourceAttributes.normal * scale + sourceAttributes.binormal, 0.0f ) );
}

// The Send family of functions prepare and emit the geometry for an input 
// primitive. They either pass through the primitive to show the indicated 
// geometry, or provide various geometric modeling conversions or visualizations
// of attributes of the geometry, like surface tangent guides.

// SendTriangle generates a normal-offset shell of the input triangle, with zero 
// offset passing the input primitive through.
void SendTriangle( float scale )
{
   SPA_GPEmitFeedbackID();

   for ( int i = 0; i < gl_in.length(); ++i )
   {
      GenerateShellVertex( DataOut.attributes, DataIn[i].attributes, scale );
      EmitVertex();
   }

   EndPrimitive();
}

// SendFaceNormal generates a line indicating the face normal vector (of a 
// normal-offset shell) of the input triangle.
void SendFaceNormal( float scale )
{
   SPA_GPEmitFeedbackID();

   // approximate centroid with average
   vec4 primitiveCentroid = vec4( 0.0, 0.0, 0.0, 0.0 );
   for ( int i = 0; i < gl_in.length(); ++i )
      primitiveCentroid += DataIn[i].attributes.position + vec4( DataIn[i].attributes.normal * scale, 0.0 );
   primitiveCentroid *= 1.0 / gl_in.length();

   // offset by normal
   vec3 faceNormal = normalize( cross( 
      DataIn[ 1 ].attributes.position.xyz - DataIn[ 0 ].attributes.position.xyz,
      DataIn[ 2 ].attributes.position.xyz - DataIn[ 0 ].attributes.position.xyz ) );

   GenerateVertexV( DataOut.attributes, DataIn[0].attributes, primitiveCentroid );
   EmitVertex();

   GenerateVertexV( DataOut.attributes, DataIn[0].attributes, primitiveCentroid + vec4( faceNormal, 0.0 ) );
   EmitVertex();

   EndPrimitive();
}

// SendVertexNormal generates a line indicating the vertex normal vector (of a 
// normal-offset shell) of the input triangle. The input primitive must define a
// vertex normal.
void SendVertexNormal( float scale )
{
   SPA_GPEmitFeedbackID();

   for ( int i = 0; i < gl_in.length(); ++i )
   {
      GenerateShellVertex( DataOut.attributes, DataIn[i].attributes, scale );
      EmitVertex();

      GenerateShellVertex( DataOut.attributes, DataIn[i].attributes, scale + 1.0 );
      EmitVertex();

      EndPrimitive();
   }
}

// SendVertexNormal generates a line strip indicating both surface tangent 
// vectors (of a normal-offset shell) of the input triangle. The input primitive 
// must define both the tangent and binormal.
void SendVertexTangents( float scale )
{
   SPA_GPEmitFeedbackID();

   for ( int i = 0; i < gl_in.length(); ++i )
   {
      GenerateTangentVertex( DataOut.attributes, DataIn[i].attributes, scale );
      EmitVertex();

      GenerateShellVertex( DataOut.attributes, DataIn[i].attributes, scale );
      EmitVertex();

      GenerateBinormalVertex( DataOut.attributes, DataIn[i].attributes, scale );
      EmitVertex();

      EndPrimitive();
   }
}

// SPA_SendTriangle processes an input triangle primitive. It appropriately 
// transforms and converts the geometry as required by defined uniforms and
// control signals from the CPU, like SPA_Guide.
void SPA_SendTriangle( float scale )
{
#if M_SPA_Guide == G_FaceNormals
   SendFaceNormal( scale );
#elif M_SPA_Guide == G_VertexNormals
   SendVertexNormal( scale );
#elif M_SPA_Guide == G_Tangents
   SendVertexTangents( scale );
#else
   SendTriangle( scale );
#endif
}

void main(void)
{
   for( int shells = 0; shells < geometryShellCount; ++shells )
   {
      SPA_SendTriangle( shells * shellScaleFactor );
   }
}
