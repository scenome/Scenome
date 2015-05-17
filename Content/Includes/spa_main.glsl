#ifndef SPA_MAIN
#define SPA_MAIN

#include <SPA_Constants.glsl>

#if __VERSION__ >= 140

#include <SPA_View.glsl>
#include <SPA_Lights.glsl>
#include <SPA_Materials.glsl>
#include <SPA_Guides.glsl>

#endif

/////////////////////////////////////////////////////////////////////////////////
// Application Edit State
/////////////////////////////////////////////////////////////////////////////////

bool SPA_IsSelected()
{
	return SPA_EditState.a == 0.5;
}

bool SPA_IsFeedback()
{
	return SPA_EditState.a == 1.0;
}

/////////////////////////////////////////////////////////////////////////////////
// Scale / Bias Functions
/////////////////////////////////////////////////////////////////////////////////

float SPA_ComputeBiasScale( in float convert, in float bias, in float scale )
{
   return convert * bias - scale;
}

vec2 SPA_ComputeBiasScale( in vec2 convert, in float bias, in float scale )
{
   return convert * bias - scale;
}

vec3 SPA_ComputeBiasScale( in vec3 convert, in float bias, in float scale )
{
   return convert * bias - scale;
}

vec4 SPA_ComputeBiasScale( in vec4 convert, in float bias, in float scale )
{
   return convert * bias - scale;
}

/////////////////////////////////////////////////////////////////////////////////
// SPA_ComputeTangentSpaceViewVector
/////////////////////////////////////////////////////////////////////////////////

vec3 SPA_ComputeTangentSpaceViewVector(

   vec3 normal,
   vec3 tangent,
   vec3 binormal,
   vec3 positionViewspace,
   mat3 normalMatrix

   )
{

   return vec3(   dot( -positionViewspace, normalMatrix * tangent  ),
                  dot( -positionViewspace, normalMatrix * binormal ),
                  dot( -positionViewspace, normalMatrix * normal ) );
}

/////////////////////////////////////////////////////////////////////////////////
// RenderOutputColor Subroutines
/////////////////////////////////////////////////////////////////////////////////

subroutine vec4 RenderOutputColor();

// The application must set this variable in order to switch the subroutine.
// In this case, there must be a SubroutineIntegerNode that handles
// the switch, either as a child of the Program or as a child of ProgramOptions.
// This SubroutineIntegerNode's variable name parameter 'renderOutputColor'.
subroutine uniform RenderOutputColor renderOutputColor;

subroutine( RenderOutputColor ) vec4 SetFragmentColorRed()
{
   return vec4( 1.0, 0.0, 0.0, 1.0 );
}

subroutine( RenderOutputColor ) vec4 SetFragmentColorGreen()
{
   return vec4( 0.0, 1.0, 0.0, 1.0 );
}

subroutine ( RenderOutputColor ) vec4 SetFragmentColorBlue()
{
   return vec4( 0.0, 0.0, 1.0, 1.0 );
}

//!SPA_MAIN
#endif
