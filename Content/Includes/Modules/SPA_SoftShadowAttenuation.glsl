#ifndef SPA_SOFTSHADOWATTENUATION
#define SPA_SOFTSHADOWATTENUATION 

/////////////////////////////////////////////////////////////////////////////////
// Soft Shadowing Variation
/////////////////////////////////////////////////////////////////////////////////

float SPA_SoftShadowAttenuation(

   sampler2D shadow_map,
   vec2 map_dims,
   vec2 nearFarZ,
   float shadowStrength,
   vec4 surface_ls,
   float bias

   )
{
   float shadow_z_ls = 0.000000;
   float scale = 0.000000;
   float shadow_attenuation = 0.000000;
   float shadow_base = 0.000000;
   vec2 map_dims_recip = vec2( 1.000000 / map_dims );
   float depth_coeff = float( float( float( nearFarZ.y - nearFarZ.y ) / float( shadowStrength * length( surface_ls ) ) ) / 100.000000 );
   for( int i = 0; i < 30; ++i )
   {
      vec4 offsetA = SPA_OffsetLookup( shadow_map,
            map_dims_recip,
            surface_ls,
      vec2( float( -15.000000 * scale ), float( float( float( i ) - 10.000000 ) * scale ) ) );
      vec4 offsetB = SPA_OffsetLookup( shadow_map,
            map_dims_recip,
            surface_ls,
      vec2( float( -5.000000 * scale ), float( float( float( i ) - 10.000000 ) * scale ) ) );
      vec4 offsetC = SPA_OffsetLookup( shadow_map,
            map_dims_recip,
            surface_ls,
      vec2( float( 5.000000 * scale ), float( float( float( i ) - 10.000000 ) * scale ) ) );
      vec4 offsetD = SPA_OffsetLookup( shadow_map,
            map_dims_recip,
            surface_ls,
      vec2( float( 15.000000 * scale ), float( float( float( i ) - 10.000000 ) * scale ) ) );
      shadow_z_ls += offsetA.z;
      shadow_z_ls += offsetB.z;
      shadow_z_ls += offsetC.z;
      shadow_z_ls += offsetD.z;

   }

   shadow_z_ls = float( shadow_z_ls / 16.000000 );

   // Compute attenuation based on depth.
   if( surface_ls.z > float( shadow_z_ls + bias ) )
   {
      if( surface_ls.z > float( float( shadow_z_ls + depth_coeff ) + bias ) )
      {
         shadow_attenuation = shadow_base;
      }
      else
      {
         shadow_attenuation = float( float( shadow_base + 1.000000 ) - float( float( surface_ls.z - shadow_z_ls ) / depth_coeff ) );
      }
   }

   return shadow_attenuation;
};

// !SPA_SOFTSHADOWATTENUATION
#endif
