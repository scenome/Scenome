#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)

#include "attributes.glsl"
#include <SPA_Fragment.glsl>

uniform sampler2D SPA_Texture0;
uniform sampler2D SPA_Texture1;
uniform int lightSourceCount;
uniform float tintAmount;
uniform vec4 tintColor;

in Data
{
   vertexData attributes;
} DataIn;

in vec3 barycentricWeight;
in vec4 color;
out vec4 fragColor;

void main(void)
{
   vec4 diffuse = texture( SPA_Texture0, DataIn.attributes.position.st * 0.125 / 8.0 );
   vec4 normalMap = texture( SPA_Texture1, DataIn.attributes.position.st * 0.125 / 8.0 );
   vec3 light = vec3( 0.0 );
   normalMap.xyz = normalMap.xyz * 2.0 - 1.0;

   for( int i = 0; i < lightSourceCount; ++i )
   {
      light += SPA_LightFragment( lights[i], materials, view.modelViewMatrix,
         view.normalMatrix, DataIn.attributes.position.xyz, DataIn.attributes.normal,
         DataIn.attributes.positionViewspace, 1.0, 1.0 ).rgb;
   }

   fragColor = diffuse * vec4( light, 1.0 );

   //fragColor = vec4( light, 1.0 );
   //fragColor = lights[0].lightAmbientColor;
   //fragColor = materials.materialAmbientColor;
   //fragColor = DataIn.attributes.position;
   //fragColor = vec4( lights[0].lightPosition );
   //fragColor = vec4( DataIn.attributes.positionViewspace, 1.0 );
}
