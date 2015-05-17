#ifndef COMPUTEEDGEBIAS
#define COMPUTEEDGEBIAS 

/////////////////////////////////////////////////////////////////////////////////
// Compute Smooth Edge Bias
/////////////////////////////////////////////////////////////////////////////////

// Courtesy Florian Boesch http://codeflow.org/

float ComputeEdgeBias( vec3 barycentricWeight, float edgeBias )
{
   vec3 d = fwidth( barycentricWeight );
   vec3 a3 = smoothstep( vec3( 0.000000, 0.000000, 0.000000 ), vec3( d * edgeBias ), barycentricWeight );
   float result = min( min( a3.x, a3.y ), a3.z );

   return result;
};

// !COMPUTEEDGEBIAS
#endif
