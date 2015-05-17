// Per-vertex attributes for the mesh.
struct GOBBLE
{
   vec4 myFvec4;
};

struct vertexData
{
   vec4 position;
   vec2 texcoord;
   vec3 normal;
   vec3 tangent;
   vec3 binormal;
   vec3 positionViewspace;
   GOBBLE instance;
   vec3 normalViewspace;
   vec3 tangentViewspace;
   vec3 binormalViewspace;
   vec4 color;
};
