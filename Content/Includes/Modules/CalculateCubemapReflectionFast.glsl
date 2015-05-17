#ifndef CALCULATECUBEMAPREFLECTIONFAST
#define CALCULATECUBEMAPREFLECTIONFAST 

/////////////////////////////////////////////////////////////////////////////////
// Compute Fast Cubemap Reflection
/////////////////////////////////////////////////////////////////////////////////

vec3 SPA_CalculateCubemapReflectionFast(

   vec3 positionViewspace,
   vec3 normalViewspace,
   mat4 textureMatrix

   )
{
   vec3 result = vec3( textureMatrix * vec4( reflect( positionViewspace, normalViewspace ), 0.000000 ) ).xyz;

   return result;
};

// !CALCULATECUBEMAPREFLECTIONFAST
#endif
