#include <SPA_Version.glsl>

#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Control.glsl>
uniform float innerTessellation;
uniform float outerTessellation;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;
uniform int lightSourceCount;
out patch float gl_TessLevelOuter[4];
out patch float gl_TessLevelInner[2];
in int gl_InvocationID;
layout(  );
in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut[];

in gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
} gl_in[];

out gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
} gl_out[];

void main(void)
{
   gl_TessLevelOuter[0] = outerTessellation;
   gl_TessLevelOuter[1] = outerTessellation;
   gl_TessLevelOuter[2] = outerTessellation;
   gl_TessLevelOuter[3] = outerTessellation;
   gl_TessLevelInner[0] = innerTessellation;
   gl_TessLevelInner[0] = innerTessellation;
   DataOut[gl_InvocationID].attributes = DataIn[gl_InvocationID].attributes;
}
