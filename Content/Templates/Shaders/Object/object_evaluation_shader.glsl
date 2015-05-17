#include <SPA_Version.glsl>

#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Evaluation.glsl>
uniform int lightSourceCount;
uniform float innerTessellation;
uniform float outerTessellation;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;
Data
{
   vertexData attributes;
} DataIn[];

Data
{
   vertexData attributes;
} DataOut;

gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
} gl_in[];

gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
} gl_out;

void main(void)
{
}
