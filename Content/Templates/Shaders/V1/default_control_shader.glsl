#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform float innerTessellation;
uniform float outerTessellation;
flat in int gl_InvocationID;
layout( vertices = 3 ) out;

in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut[];

void main(void)
{
   // Assign tessellation values. Do all four outer values to make sure this supports quads easily.
   gl_TessLevelOuter[0] = outerTessellation;
   gl_TessLevelOuter[1] = outerTessellation;
   gl_TessLevelOuter[2] = outerTessellation;
   gl_TessLevelOuter[3] = outerTessellation;
   gl_TessLevelInner[0] = innerTessellation;
   gl_TessLevelInner[1] = innerTessellation;
   DataOut[gl_InvocationID].attributes = DataIn[gl_InvocationID].attributes;
}

