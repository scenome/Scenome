#include <SPA_Fragment.glsl>
uniform sampler2D SPA_Texture0;
varying vec2 texcoord0;
varying vec4 color0;

void main()
{
   vec4 texture0 = texture2D( SPA_Texture0, texcoord0 );
   if( texture0 != vec4( vec3( 0.0 ), 1.0 ) )
   {
      gl_FragColor = color0 * texture0;
   }
   else
   {
      gl_FragColor = color0;
   }
}
