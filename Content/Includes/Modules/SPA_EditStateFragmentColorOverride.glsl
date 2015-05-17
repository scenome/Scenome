#ifndef SPA_EDITSTATEFRAGMENTCOLOROVERRIDE
#define SPA_EDITSTATEFRAGMENTCOLOROVERRIDE 

/////////////////////////////////////////////////////////////////////////////////
// Application Edit State
/////////////////////////////////////////////////////////////////////////////////

// This function overrides output colors to support selection and 
// feedback pick rendering. Call this on the output value immediately
// before assigning it to the fragment shader output ( EX: fragColor, gl_FragColor ).
// The function returns true during selection or feedback rendering, and
// false otherwise.
bool SPA_EditStateFragmentColorOverride( inout vec4 colorOutput )
{
   bool a_bIsEditState = SPA_EditState.a > 0.0;

   if( SPA_EditState.a == 0.5 )
   {
      colorOutput = SPA_EditState;
   }
   else
   if( SPA_EditState.a == 1.0 )
   {
      colorOutput.x = float( int( gl_PrimitiveID / 65536 ) & 255 ) / 255.0;
      colorOutput.y = float( int( gl_PrimitiveID >> 8 ) & 255 ) / 255.0;
      colorOutput.z = float( gl_PrimitiveID & 255 ) / 255.0;
      colorOutput.w = 1.0;
   }

	return a_bIsEditState;
}

// !SPA_EDITSTATEFRAGMENTCOLOROVERRIDE

#endif
