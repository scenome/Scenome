vec3 SPA_LIGHT_SPECULAR_FUNCTION( vec3 Position_Viewspace, vec3 Normal_Viewspace, float Specular_Exponent )
{
   // calculate the specular reflection color
   vec3 light_specular;
   // Surface-to-light vector = L
   vec3 a_vL = vec3( gl_LightSource[ SPA_LIGHT_INDEX ].position.xyz );
   a_vL -= vec3( Position_Viewspace.xyz );
   a_vL = normalize( a_vL );
   // Surface normal = N
   vec3 normal_viewspace_normal = normalize( Normal_Viewspace );

   // Reflected light vector, negated to be used below = -R
   vec3 a_vNegativeReflectL = a_vL - normal_viewspace_normal * vec3( dot( a_vL, normal_viewspace_normal ) * 2.0 );
   light_specular = gl_FrontMaterial.specular.rgb * pow( max(dot( a_vNegativeReflectL, Position_Viewspace.xyz ) / length( Position_Viewspace.xyz ), 0.0), Specular_Exponent );
 
   return light_specular;
}