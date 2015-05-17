#ifndef CALCULATEDISTANCEFADE
#define CALCULATEDISTANCEFADE 

/////////////////////////////////////////////////////////////////////////////////
// Calculate Distance Fade
/////////////////////////////////////////////////////////////////////////////////

float CalculateDistanceFade(

   float distanceFromCameraToPoint,
   float fadeStart,
   float fadeEnd

   )
{
   // Mix diffuse and detail based on inverse exponential distance to camera. We want
   // to hit black at the fade end so  multiply by 5 since e^-5x is close to zero at
   // x = 1.
   float gradient = exp( float( float( -5.000000 * float( distanceFromCameraToPoint - fadeStart ) ) / float( fadeEnd - fadeStart ) ) );
   float result = float( 1.000000 - clamp( gradient, 0.000000, 1.000000 ) );

   return result;
};

// !CALCULATEDISTANCEFADE
#endif
