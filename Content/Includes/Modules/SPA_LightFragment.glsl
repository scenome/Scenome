#ifndef SPA_LIGHTFRAGMENT
#define SPA_LIGHTFRAGMENT 
#include <SPA_View.glsl>
#include <SPA_Lights.glsl>

/////////////////////////////////////////////////////////////////////////////////
// SPA_LightFragment
/////////////////////////////////////////////////////////////////////////////////

vec4 SPA_LightFragment(

   const SPA_Light light,
   const SPA_Material material,
   const mat4 modelViewMatrix,
   const mat3 normalMatrix,
   const vec3 position,
   const vec3 normal,
   const vec3 positionViewspace,
   const float specularMask,
   const float shadowAttenuation

   )
{
   // normal * light direction
   float nDotVP;

   // normal * light reflection vector
   float nDotR;

   // power factor
   float pf;

   // computed attenuation factor
   float attenuation;

   // distance from surface to light position
   float d;

   // direction from surface to light position
   vec3 VP;

   // direction of maximum highlights
   vec3 reflection;

   // Compute lighting
   VP = normalize( vec3( light.lightPosition.xyz - positionViewspace ) );
   vec3 tnorm = normalize( vec3( normalMatrix * normal ) );
   d = length( VP );
   attenuation = float( 1.000000 / float( float( light.lightConstantAttenuation + light.lightLinearAttenuation ) + light.lightQuadraticAttenuation ) );
   reflection = normalize( reflect( -normalize( VP ), normalize( tnorm ) ) );
   nDotVP = max( 0.000000, dot( tnorm, VP ) );
   nDotR = max( 0.000000, dot( normalize( normal ), reflection ) );
   float clampAttenuation = clamp( attenuation, 0.000000, 1.000000 );
   if( nDotVP == 0.000000 )
   {
      pf = 0.000000;
   }
   else
   {
      pf = pow( max( nDotR, 0.000000 ), material.materialShininess );
   }

   vec4 ambient = vec4( vec4( material.materialAmbientColor * light.lightAmbientColor ) * clampAttenuation );
   vec4 diffuse = vec4( vec4( material.materialDiffuseColor * light.lightDiffuseColor ) * float( nDotVP * clampAttenuation ) );
   vec4 specular = vec4( material.materialSpecularColor * vec4( light.lightSpecularColor * float( float( pf * clampAttenuation ) * float( specularMask * shadowAttenuation ) ) ) );

   return vec4( vec4( ambient + diffuse ) + specular );
};

// !SPA_LIGHTFRAGMENT
#endif
