#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec4 fs_Nor;
out vec4 fs_LightVec;

void main()
{
    fs_Nor = normalize(vec4(u_ModelInvTr * vec3(vs_Nor), 0)); // Pass the vertex normals to the fragment shader for interpolation.
                                                             // Transform the geometry's normals by the inverse transpose of the
                                                             // model matrix. This is necessary to ensure the normals remain
                                                             // perpendicular to the surface after the surface is transformed by
                                                             // the model matrix.


    vec4 modelposition = u_Model * vs_Pos;   // Temporarily store the transformed vertex positions for use below

    fs_LightVec = (inverse(u_View) * vec4(0,0,0,1)) - modelposition;  // Compute the direction in which the light source lies

    gl_Position = u_Proj * u_View * modelposition;// gl_Position is a built-in variable of OpenGL which is
                                                  // used to render the final positions of the geometry's vertices
}
