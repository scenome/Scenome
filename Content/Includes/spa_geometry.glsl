#ifndef SPA_GEOMETRY
#define SPA_GEOMETRY 

#include <SPA_Main.glsl>

#if __VERSION__ >= 130

// This function emits a feedback identifier for a primitive. Call this function
// in the geometry program to support selection rendering and feedback picking.
void SPA_GPEmitFeedbackID()
{
   gl_PrimitiveID = SPA_BaseObjectID + ( SPA_UsePerObjectID ? gl_PrimitiveIDIn : 0 );
}

#endif

const int PointsPerLine = int( 2 );
const int VertsPerTri = int( 3 );
const int MaxShells = int( 3 );
const int TangentsPerVert = int( 2 );

// !SPA_GEOMETRY
#endif
