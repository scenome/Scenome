#ifndef SPA_EVALUATION
#define SPA_EVALUATION

#include <SPA_Main.glsl>

#if __VERSION__ >= 400

/////////////////////////////////////////////////////////////////////////////////
// Barycentric interpolation for triangles.
/////////////////////////////////////////////////////////////////////////////////

float InterpolateBarycentric( in float a, in float b, in float c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec2 InterpolateBarycentric( in vec2 a, in vec2 b, in vec2 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec3 InterpolateBarycentric( in vec3 a, in vec3 b, in vec3 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

vec4 InterpolateBarycentric( in vec4 a, in vec4 b, in vec4 c )
{
   return gl_TessCoord.x * a + gl_TessCoord.y * b + gl_TessCoord.z * c;
}

/////////////////////////////////////////////////////////////////////////////////
// Generic barycentric interpolation.
/////////////////////////////////////////////////////////////////////////////////

float InterpolateTriangle( in int address, in float a )
{
   return gl_TessCoord[address] * a;
}

vec2 InterpolateTriangle( in int address, in vec2 a )
{
   return gl_TessCoord[address] * a;
}

vec3 InterpolateTriangle( in int address, in vec3 a )
{
   return gl_TessCoord[address] * a;
}

vec4 InterpolateTriangle( in int address, in vec4 a )
{
   return gl_TessCoord[address] * a;
}

/////////////////////////////////////////////////////////////////////////////////
// Barycentric interpolation for triangles using shorthand notation.
/////////////////////////////////////////////////////////////////////////////////

float InterpolateT( in int address, in float a )
{
   return gl_TessCoord[address] * a;
}

vec2 InterpolateT( in int address, in vec2 a )
{
   return gl_TessCoord[address] * a;
}

vec3 InterpolateT( in int address, in vec3 a )
{
   return gl_TessCoord[address] * a;
}

vec4 InterpolateT( in int address, in vec4 a )
{
   return gl_TessCoord[address] * a;
}

#endif

//!SPA_EVALUATION
#endif