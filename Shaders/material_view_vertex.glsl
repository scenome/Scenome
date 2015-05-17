attribute vec2 SPA_TexCoord0;
attribute vec4 SPA_Color0;
varying vec2 texcoord0;
varying vec4 color0;

void main()
{
   color0 = SPA_Color0;
   texcoord0 = SPA_TexCoord0;
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
