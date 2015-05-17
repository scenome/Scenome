
vec4 SPA_LIGHT_FRAGMENT_FUNCTION( in vec3 position, in vec3 normal, in float shadow_atten )
{
	vec4 a_vL = gl_LightSource[ SPA_LIGHT_INDEX ].position;
	float a_fAtten = 1.0;
	if ( gl_LightSource[ SPA_LIGHT_INDEX ].position.w != 0.0 )
	{
		a_vL.xyz -= position.xyz;

		float a_fL2 = dot( a_vL.xyz, a_vL.xyz );
		float a_fL = sqrt( a_fL2 );
		a_fAtten = gl_LightSource[ SPA_LIGHT_INDEX ].constantAttenuation + 
			gl_LightSource[ SPA_LIGHT_INDEX ].linearAttenuation * a_fL + 
			gl_LightSource[ SPA_LIGHT_INDEX ].quadraticAttenuation * a_fL2;
		a_fAtten = 1.0 / a_fAtten;
		a_vL *= 1.0 / a_fL;

		if ( gl_LightSource[ SPA_LIGHT_INDEX ].spotCosCutoff > -1.0 )
		{
			float a_fLDotS = -dot( a_vL.xyz, gl_LightSource[ SPA_LIGHT_INDEX ].spotDirection );
			if ( a_fLDotS < gl_LightSource[ SPA_LIGHT_INDEX ].spotCosCutoff )
				a_fAtten = 0.0;
			else
				a_fAtten *= pow( a_fLDotS, gl_LightSource[ SPA_LIGHT_INDEX ].spotExponent );
		}
	}

	a_vL.w = 0.0;

	float a_fLightDiffuse;
	a_fLightDiffuse = dot( normal.xyz, a_vL.xyz );
	a_fLightDiffuse = clamp( a_fLightDiffuse, 0.0, 1.0 );

	return gl_FrontLightModelProduct.sceneColor + a_fAtten * ( gl_FrontMaterial.emission + 
		gl_FrontLightProduct[ SPA_LIGHT_INDEX ].ambient + 
		vec4( ( shadow_atten * a_fLightDiffuse * gl_FrontLightProduct[ SPA_LIGHT_INDEX ].diffuse ).xyz, 1.0 ) );
}
