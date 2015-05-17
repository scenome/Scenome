#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

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
   DataOut.attributes.color = SPA_Color0;
   DataOut.attributes.normalViewspace = vec3( modelViewMatrix * vec4( SPA_Normal0, 1.0 ) ).xyz;
   DataOut.attributes.tangentViewspace = vec3( modelViewMatrix * vec4( SPA_Normal1, 1.0 ) ).xyz;
   DataOut.attributes.binormalViewspace = vec3( modelViewMatrix * vec4( SPA_Normal2, 1.0 ) ).xyz;
   DataOut.attributes.positionViewspace = vec3( modelViewMatrix * DataOut.attributes.position ).xyz;

   // Skip unless the tessellation shader and geometry shader are omitted.
   //gl_Position = modelViewProjectionMatrix * DataOut.attributes.position;
}
