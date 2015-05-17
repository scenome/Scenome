#ifndef SPA_VERTEX
#define SPA_VERTEX

#include <SPA_Main.glsl>

/////////////////////////////////////////////////////////////////////////////////
// Shadows
/////////////////////////////////////////////////////////////////////////////////

vec3 SPA_ShadowSpacePos( mat4 lightProjectionMatrix, vec3 surface_vs )
{
   vec4 surface_ls = lightProjectionMatrix * vec4( surface_vs, 1.0 );
   surface_ls.xyz /= surface_ls.w;

   surface_ls.xyz *= vec3( 0.5 );
   surface_ls.xyz += vec3( 0.5 );

   return surface_ls.xyz;
}

//!SPA_VERTEX
#endif