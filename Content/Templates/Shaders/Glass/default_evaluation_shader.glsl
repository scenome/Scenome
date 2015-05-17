#include <SPA_Version.glsl>
#pragma optimize(on)
#pragma debug(off)
#include "attributes.glsl"
#include <SPA_Evaluation.glsl>
uniform int lightSourceCount;
uniform bool VerticesOn;
uniform float innerTessellation;
uniform float outerTessellation;
uniform int geometryShellCount;
uniform float shellScaleFactor;
uniform vec4 tintColor;
uniform float tintAmount;
uniform float parallaxScale;
uniform float parallaxBias;

layout( triangles, equal_spacing, ccw ) in;
in Data
{
   vertexData attributes;
} DataIn[];

out Data
{
   vertexData attributes;
} DataOut;

void main(void)
{
   DataOut.attributes.position = InterpolateBarycentric( DataIn[0].attributes.position, DataIn[1].attributes.position, DataIn[2].attributes.position );
   DataOut.attributes.texcoord = InterpolateBarycentric( DataIn[0].attributes.texcoord, DataIn[1].attributes.texcoord, DataIn[2].attributes.texcoord );
   DataOut.attributes.normal = InterpolateBarycentric( DataIn[0].attributes.normal, DataIn[1].attributes.normal, DataIn[2].attributes.normal );
   DataOut.attributes.tangent = InterpolateBarycentric( DataIn[0].attributes.tangent, DataIn[1].attributes.tangent, DataIn[2].attributes.tangent );
   DataOut.attributes.binormal = InterpolateBarycentric( DataIn[0].attributes.binormal, DataIn[1].attributes.binormal, DataIn[2].attributes.binormal );
   DataOut.attributes.positionViewspace = InterpolateBarycentric( DataIn[0].attributes.positionViewspace, DataIn[1].attributes.positionViewspace, DataIn[2].attributes.positionViewspace );
   DataOut.attributes.normalViewspace = InterpolateBarycentric( DataIn[0].attributes.positionViewspace, DataIn[1].attributes.positionViewspace, DataIn[2].attributes.positionViewspace );
   DataOut.attributes.tangentViewspace = InterpolateBarycentric( DataIn[0].attributes.tangentViewspace, DataIn[1].attributes.tangentViewspace, DataIn[2].attributes.tangentViewspace );
   DataOut.attributes.binormalViewspace = InterpolateBarycentric( DataIn[0].attributes.binormalViewspace, DataIn[1].attributes.binormalViewspace, DataIn[2].attributes.binormalViewspace );
   DataOut.attributes.color = InterpolateBarycentric( DataIn[0].attributes.color, DataIn[1].attributes.color, DataIn[2].attributes.color );
   gl_Position = vec4( view.modelViewProjectionMatrix * DataOut.attributes.position );
}
