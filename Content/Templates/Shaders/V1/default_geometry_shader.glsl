#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"

layout( triangles ) in;
layout (triangle_strip, max_vertices = 12 ) out;
uniform int geometryShellCount;
uniform float shellScaleFactor;
uniform mat4x4 modelViewProjectionMatrix;

in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut;

out vec3 barycentricWeight;

void SendTriangle( float scale )
{
   for ( int i = 0; i < gl_in.length(); ++i )
   {
      barycentricWeight = vec3( 0.0 );
      DataOut.attributes.position = DataIn[i].attributes.position;
      DataOut.attributes.texcoord = DataIn[i].attributes.texcoord;
      DataOut.attributes.normal = DataIn[i].attributes.normal;
      DataOut.attributes.tangent = DataIn[i].attributes.tangent;
      DataOut.attributes.binormal = DataIn[i].attributes.binormal;
      DataOut.attributes.normalViewspace = DataIn[i].attributes.normalViewspace;
      DataOut.attributes.tangentViewspace = DataIn[i].attributes.tangentViewspace;
      DataOut.attributes.binormalViewspace = DataIn[i].attributes.binormalViewspace;
      DataOut.attributes.positionViewspace = DataIn[i].attributes.positionViewspace;
      DataOut.attributes.selectionColor = DataIn[i].attributes.selectionColor;
      DataOut.attributes.color = DataIn[i].attributes.color;
      gl_Position = DataIn[i].attributes.position;
		gl_Position.xyz *= shellScaleFactor;
      gl_Position.z += scale;
		gl_Position = modelViewProjectionMatrix * gl_Position;
      barycentricWeight[i] = 1.0;
      EmitVertex();
   }

   EndPrimitive();
}

void main(void)
{
   for( int shell = 0; shell < geometryShellCount; ++shell )
   {
      SendTriangle( shell );
   }
}
