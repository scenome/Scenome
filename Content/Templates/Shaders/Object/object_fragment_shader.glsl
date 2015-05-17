#include <SPA_Version.glsl>

#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Fragment.glsl>

uniform int lightSourceCount;
uniform float innerTessellation;
uniform float outerTessellation;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;
uniform sampler2DArray SPA_Texture0;
uniform samplerCube SPA_Texture1;
in Data
{
   vertexData attributes;
} DataIn;

struct myStruct
{
   bool innerSpace;
   vec3 distance;
   mat4x4 packedDistances;
};

out vec4 fragColor;
void main(void)
{
   vec2 parallaxTextureCoords;
   vec3 glossCoords;
   vec3 someColor;
   vec3 light;
   vec3 parallaxNormalViewspace;
   vec4 blueMask;
   vec4 blend;
   vec4 maskedNormal;
   vec4 elevation = texture( SPA_Texture0, vec3( DataIn.attributes.texcoord, 0.000000 ) );
   parallaxTextureCoords = SPA_CalculateParallaxOffsetTexCoordsFast( DataIn.attributes.tangentViewVector,
         DataIn.attributes.texcoord,
         elevation.a,
         parallaxScale,
         parallaxBias );
   vec4 array_diffuse = texture( SPA_Texture0, vec3( parallaxTextureCoords, 0.000000 ) );
   vec4 array_normal = texture( SPA_Texture0, vec3( parallaxTextureCoords, 1.000000 ) );
   vec4 array_gloss = texture( SPA_Texture0, vec3( parallaxTextureCoords, 2.000000 ) );
   vec4 array_detail = texture( SPA_Texture0, vec3( parallaxTextureCoords, 3.000000 ) );
   array_normal.rgb = vec3( vec3( array_normal.rgb * 2.000000 ) - 1.000000 );
   blueMask = vec4( 0.000000, 0.000000, 1.000000, 0.000000 );
   maskedNormal = mix( array_normal, blueMask, array_gloss.a );
   glossCoords = SPA_CalculateCubemapReflectionFast( DataIn.attributes.positionViewspace, DataIn.attributes.normalViewspace, view.textureMatrix );
   vec4 glossMap = texture( SPA_Texture1, glossCoords );
   parallaxNormalViewspace = vec3( view.modelViewMatrix * vec4( maskedNormal.rgb, 0.000000 ) );
   light = vec3( SPA_LightFragment( lights[1],
         materials,
         view.modelViewMatrix,
         view.normalMatrix,
         DataIn.attributes.position.xyz,
         maskedNormal.xyz,
         DataIn.attributes.positionViewspace,
         elevation.a,
         1.000000 ) );
   blend = vec4( mix( array_diffuse, glossMap, array_gloss.a ) * vec4( light, 0.000000 ) );
   fragColor = blend;
}
