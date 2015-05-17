#ifndef SPA_FRAGMENT
#define SPA_FRAGMENT 
#include <SPA_Main.glsl>
#include <Modules\ComputeEdgeBias.glsl>
#include <Modules\ComputeSlopeFromNormalMap.glsl>
#include <Modules\CalculateDistanceFade.glsl>
#include <Modules\CalculateParallaxOffsetTexCoordsFast.glsl>
#include <Modules\CalculateCubemapReflectionFast.glsl>
#include <Modules\SPA_LightFragment.glsl>
#include <Modules\CalculateFogVolume_Sample.glsl>
#include <Modules\SPA_OffsetLookup.glsl>
#include <Modules\SPA_SoftShadowAttenuation.glsl>
#include <Modules\SPA_EditStateFragmentColorOverride.glsl>
int intTest;
const int lightIndex = int( 1 );

// !SPA_FRAGMENT

#endif
