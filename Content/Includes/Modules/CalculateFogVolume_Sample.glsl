#ifndef CALCULATEFOGVOLUME_SAMPLE
#define CALCULATEFOGVOLUME_SAMPLE 

/////////////////////////////////////////////////////////////////////////////////
// Compute Fog
/////////////////////////////////////////////////////////////////////////////////

float SPA_CalculateFogVolume_Sample(

   vec3 positionViewspace,
   vec4 fogPlaneViewspace,
   SPA_View view

   )
{
   float fogDepth;
   float cameraDistanceToFragment = length( positionViewspace );
   float fragmentZDepth = dot( fogPlaneViewspace, vec4( positionViewspace, 0.000000 ) );
   if( fogPlaneViewspace.w > 0.000000 )
   {
      // Camera out of fog
      if( fragmentZDepth > 0.000000 )
      {
         // Fragment out of fog
         fogDepth = 0.000000;
      }
      else
      {
         // Fragment in fog
         fogDepth = float( -fragmentZDepth / float( fogPlaneViewspace.w - fragmentZDepth ) );
      }
   }
   else
   {
      // Camera in fog
      if( fragmentZDepth > 0.000000 )
      {
         // Fragment out of fog
         fogDepth = float( -fogPlaneViewspace.w / float( fragmentZDepth - fogPlaneViewspace.w ) );
      }
      else
      {
         // Fragment in fog
         fogDepth = 1.000000;
      }
   }

   return fogDepth;
};


// !CALCULATEFOGVOLUME_SAMPLE
#endif
