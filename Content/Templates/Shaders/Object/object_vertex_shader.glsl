#include <SPA_Version.glsl>

#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Vertex.glsl>

uniform float innerTessellation;
uniform float outerTessellation;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;
uniform int lightSourceCount;
in vec4 SPA_Position0;
in vec2 SPA_TexCoord0;
in vec3 SPA_Normal0;
in vec3 SPA_Normal1;
in vec3 SPA_Normal2;
out Data
{
   vertexData attributes;
} DataOut;

out gl_PerVertex
{
   vec4 gl_Position;
   float gl_PointSize;
   float gl_ClipDistance[];
};

void main(void)
{
   DataOut.attributes.position = SPA_Position0;
   DataOut.attributes.texcoord = SPA_TexCoord0;
   DataOut.attributes.normal = SPA_Normal0;
   DataOut.attributes.tangent = SPA_Normal1;
   DataOut.attributes.binormal = SPA_Normal2;
   DataOut.attributes.positionViewspace = vec3( view.modelViewMatrix * SPA_Position0 );
   DataOut.attributes.normalViewspace = vec3( view.modelViewMatrix * vec4( SPA_Normal0, 0.000000 ) );
   DataOut.attributes.tangentViewVector = SPA_ComputeTangentSpaceViewVector( SPA_Normal0,
         SPA_Normal1,
         SPA_Normal2,
         DataOut.attributes.positionViewspace,
         view.normalMatrix );
   gl_Position = vec4( view.modelViewProjectionMatrix * SPA_Position0 );
}
