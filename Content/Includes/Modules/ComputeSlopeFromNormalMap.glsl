#ifndef COMPUTESLOPEFROMNORMALMAP
#define COMPUTESLOPEFROMNORMALMAP 

/////////////////////////////////////////////////////////////////////////////////
// Compute Slope From Normal Map
/////////////////////////////////////////////////////////////////////////////////

float SPA_ComputeSlopeFromNormal( vec3 normalMap )
{
   // Compute slope from normal z.
   return float( 1.000000 - normalMap.z );
};

// !COMPUTESLOPEFROMNORMALMAP
#endif
