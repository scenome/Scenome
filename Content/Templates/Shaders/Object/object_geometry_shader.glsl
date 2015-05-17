#include <SPA_Version.glsl>

#include "attributes.glsl"
#include <SPA_Geometry.glsl>

#define G_FaceNormals 2
in Data
{
   vertexData instance;
} DataIn[];

out Data
{
   vertexData instance;
} DataOut;

in gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
} gl_in[];

out gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
};

void main(void)
{
}
