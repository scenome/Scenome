// Per-vertex attributes for this mesh.
struct Hungry
{
   bool getsToEat;
};

struct vertexData
{
   vec4 position;
   vec2 texcoord;
   vec3 normal;
   vec3 tangent;
   vec3 binormal;
   vec3 positionViewspace;
   vec3 normalViewspace;
   vec3 tangentViewspace;
   vec3 binormalViewspace;
   vec3 tangentViewVector;
   vec4 color;
   Hungry instance;
   vec4 centerPoint;
};
