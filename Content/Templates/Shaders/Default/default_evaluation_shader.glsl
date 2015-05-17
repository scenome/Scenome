#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

layout( triangles, equal_spacing, ccw ) in;

float InterpolateBarycentric( in float a, in float b, in float c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec2 InterpolateBarycentric( in vec2 a, in vec2 b, in vec2 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec3 InterpolateBarycentric( in vec3 a, in vec3 b, in vec3 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec4 InterpolateBarycentric( in vec4 a, in vec4 b, in vec4 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut;

void main(void)
{
   DataOut.attributes.position = InterpolateBarycentric( DataIn[0].attributes.position,
      DataIn[1].attributes.position, DataIn[2].attributes.position );

   DataOut.attributes.texcoord = InterpolateBarycentric( DataIn[0].attributes.texcoord,
      DataIn[1].attributes.texcoord, DataIn[2].attributes.texcoord );

   DataOut.attributes.normal = InterpolateBarycentric( DataIn[0].attributes.normal,
      DataIn[1].attributes.normal, DataIn[2].attributes.normal );

   DataOut.attributes.tangent = InterpolateBarycentric( DataIn[0].attributes.tangent,
      DataIn[1].attributes.tangent, DataIn[2].attributes.tangent );

   DataOut.attributes.binormal = InterpolateBarycentric( DataIn[0].attributes.binormal,
      DataIn[1].attributes.binormal, DataIn[2].attributes.binormal );

   DataOut.attributes.color = InterpolateBarycentric( DataIn[0].attributes.color,
      DataIn[1].attributes.color, DataIn[2].attributes.color );

   DataOut.attributes.normalViewspace = InterpolateBarycentric( DataIn[0].attributes.normalViewspace,
      DataIn[1].attributes.normalViewspace, DataIn[2].attributes.normalViewspace );

   DataOut.attributes.tangentViewspace = InterpolateBarycentric( DataIn[0].attributes.tangentViewspace,
      DataIn[1].attributes.tangentViewspace, DataIn[2].attributes.tangentViewspace );

   DataOut.attributes.binormalViewspace = InterpolateBarycentric( DataIn[0].attributes.binormalViewspace,
      DataIn[1].attributes.binormalViewspace, DataIn[2].attributes.binormalViewspace );

   DataOut.attributes.positionViewspace = InterpolateBarycentric( DataIn[0].attributes.positionViewspace,
      DataIn[1].attributes.positionViewspace, DataIn[2].attributes.positionViewspace );

   DataOut.attributes.selectionColor = InterpolateBarycentric( DataIn[0].attributes.selectionColor,
      DataIn[1].attributes.selectionColor, DataIn[2].attributes.selectionColor );

   // Skip this unless the geometry shader is omitted.
   // gl_Position = modelViewProjectionMatrix * DataOut.attributes.position;
}
