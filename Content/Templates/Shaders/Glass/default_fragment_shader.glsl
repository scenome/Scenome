#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Fragment.glsl>
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
uniform sampler2D SPA_Texture0;
out vec4 fragColor;
const int lightSelector = int( 1 );
in Data
{
   vertexData attributes;
} DataIn;

void main(void)
{
   vec3 light;
   vec4 albedo = texture( SPA_Texture0, DataIn.attributes.texcoord );
   light = vec3( SPA_LightFragment( lights[lightSelector],
         materials,
         view.modelViewMatrix,
         view.normalMatrix,
         DataIn.attributes.position.xyz,
         DataIn.attributes.normal,
         DataIn.attributes.positionViewspace,
         1.000000,
         1.000000 ) ).rgb;
   albedo *= vec4( light, 0.000000 );
   fragColor = albedo;
}
