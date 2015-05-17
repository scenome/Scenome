#ifndef CALCULATEPARALLAXOFFSETTEXCOORDSFAST
#define CALCULATEPARALLAXOFFSETTEXCOORDSFAST 

/////////////////////////////////////////////////////////////////////////////////
// Compute Fast Parallax Offset
/////////////////////////////////////////////////////////////////////////////////

vec2 SPA_CalculateParallaxOffsetTexCoordsFast(

   vec3 viewVector,
   vec2 texcoord,
   float elevation,
   float texScale,
   float texBias

   )
{
   vec2 result = vec2( texcoord + vec2( vec2( float( elevation * texScale ) - texBias ) * vec2( normalize( viewVector ) ).xy ) );

   return result;
};

// !CALCULATEPARALLAXOFFSETTEXCOORDSFAST
#endif
