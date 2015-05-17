#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Geometry.glsl>
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

layout( triangles, invocations = 1 ) in;
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
}
