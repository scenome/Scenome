#ifndef SPA_HARDSHADOWATTENUATION
#define SPA_HARDSHADOWATTENUATION 

/////////////////////////////////////////////////////////////////////////////////
// Soft Shadowing Variation
/////////////////////////////////////////////////////////////////////////////////

float SPA_HardShadowAttenuation( sampler2D shadow_map, vec4 surface_ls, float bias )
{
   float shadow_z_ls = 1.000000;
   float shadow_attenuation = 0.000000;
   if( surface_ls.z > float( shadow_z_ls + bias ) )
   {
      if( surface_ls.z > float( float( shadow_z_ls + 0.000000 ) + bias ) )
      {
         // In shadow
         shadow_attenuation = 0.000000;
      }
   }

   return shadow_attenuation;
};

// !SPA_HARDSHADOWATTENUATION
#endif
