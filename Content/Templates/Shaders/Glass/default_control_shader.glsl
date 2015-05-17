#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#define VERTEX_COUNT 3
#include "attributes.glsl"
#include <SPA_Control.glsl>
uniform int lightSourceCount;
uniform bool VerticesOn;
uniform float innerTessellation;
uniform float outerTessellation;
uniform int geometryShellCount;
uniform float shellScaleFactor;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;

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
   gl_TessLevelOuter[0] = outerTessellation;
   gl_TessLevelOuter[1] = outerTessellation;
   gl_TessLevelOuter[2] = outerTessellation;
   gl_TessLevelOuter[3] = outerTessellation;
   gl_TessLevelInner[0] = innerTessellation;
   gl_TessLevelInner[1] = innerTessellation;
   DataOut[gl_InvocationID].attributes = DataIn[gl_InvocationID].attributes;
   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
