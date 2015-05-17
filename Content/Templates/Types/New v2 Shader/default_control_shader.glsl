#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Control.glsl>

layout( vertices = 3 ) out;

uniform float innerTessellation;
uniform float outerTessellation;

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
   gl_TessLevelOuter[0] = outerTessellation;
   gl_TessLevelOuter[1] = outerTessellation;
   gl_TessLevelOuter[2] = outerTessellation;
   gl_TessLevelOuter[3] = outerTessellation;
   gl_TessLevelInner[0] = innerTessellation;
   gl_TessLevelInner[1] = innerTessellation;
   DataOut[gl_InvocationID].attributes = DataIn[gl_InvocationID].attributes;
}
