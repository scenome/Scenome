#ifndef SPA_OFFSETLOOKUP
#define SPA_OFFSETLOOKUP 

/////////////////////////////////////////////////////////////////////////////////
// SPA_OffsetLookup
/////////////////////////////////////////////////////////////////////////////////

// Percentage closer filtering courtesy of NVIDIA. Source: http://http.developer.nvidia.com/GPUGems/gpugems_ch11.html

vec4 SPA_OffsetLookup(

   sampler2D map,
   vec2 texMapScale,
   vec4 loc,
   vec2 offsetShift

   )
{
   vec4 result = textureProj( map, vec4( vec2( vec2( loc.xy + offsetShift ) * vec2( texMapScale * loc.w ) ), loc.z, loc.w ), 0.000000 );

   return result;
};

// !SPA_OFFSETLOOKUP
#endif
