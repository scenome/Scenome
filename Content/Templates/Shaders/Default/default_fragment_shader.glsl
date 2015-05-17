#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"

#include <SPA_Fragment.glsl>

uniform sampler2D SPA_Texture0;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;
uniform vec4 lightDiffuseColor;
uniform vec4 materialDiffuseColor;
uniform vec4 tintColor;
uniform float tintAmount;

in Data
{
   vertexData attributes;
} DataIn;

out vec4 fragColor;

void main(void)
{
   // Sample texture
   vec4 diffuse = texture( SPA_Texture0, DataIn.attributes.texcoord );

   // Do very simple diffuse lighting.
   vec3 transformedNormal = normalize( normalMatrix * DataIn.attributes.normal );
   vec3 s = normalize( vec3( lightPosition.xyz - DataIn.attributes.positionViewspace ) );   
   vec4 light = lightDiffuseColor * materialDiffuseColor * max( dot( vec4( s, 1.0 ), vec4( transformedNormal, 1.0 ) ), 0.0 );

   // Render
   diffuse *= ( tintColor * tintAmount ) * vec4( light.rgb, 1.0 );
   SPA_EditStateFragmentColorOverride( diffuse );
   fragColor = diffuse * light;
   
   // Debug: Render Texcoords / Position / Etc.
   //fragColor = vec4( DataIn.attributes.texcoord, 1.0, 1.0 );
   //fragColor = DataIn.attributes.position;
   //fragColor = vec4( DataIn.attributes.normalViewspace, 1.0 );
   //fragColor = vec4( DataIn.attributes.normal, 1.0 );
}
