#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Vertex.glsl>

in vec4 SPA_Position0;
in vec2 SPA_TexCoord0;
in vec3 SPA_Normal0;
in vec3 SPA_Normal1;
in vec3 SPA_Normal2;
in vec4 SPA_Color0;

out Data
{
   vertexData attributes;
} DataOut;

void main(void)
{
   DataOut.attributes.position = SPA_Position0;
   DataOut.attributes.texcoord = SPA_TexCoord0;
   DataOut.attributes.normal = SPA_Normal0;
   DataOut.attributes.tangent = SPA_Normal1;
   DataOut.attributes.binormal = SPA_Normal2;
   DataOut.attributes.normalViewspace = vec3( view.modelViewMatrix * vec4( SPA_Normal0, 0.0 ) ).xyz;
   DataOut.attributes.tangentViewspace = vec3( view.modelViewMatrix * vec4( SPA_Normal1, 0.0 ) ).xyz;
   DataOut.attributes.binormalViewspace = vec3( view.modelViewMatrix * vec4( SPA_Normal2, 0.0 ) ).xyz;
   DataOut.attributes.color = SPA_Color0;
   DataOut.attributes.positionViewspace = vec3( view.modelViewMatrix * DataOut.attributes.position ).xyz;
   //gl_Position = vec4( view.modelViewProjectionMatrix * SPA_Position0 );
}
