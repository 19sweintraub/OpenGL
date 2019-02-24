#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;

in vec4 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_LightVec;
in float fs_Noise;

layout(location = 0) out vec3 out_Col;

void main()
{
    // Calculate the diffuse term for Lambert shading
    float t = dot(normalize(fs_Nor), normalize(fs_LightVec));
    // Avoid negative lighting values
    t = clamp(t, 0, 1);

    vec3 a = vec3(0.5, 0.5, 0.5) - 0.1*sin(u_Time/15.0)*(fs_Noise);
    vec3 b = vec3(0.5, 0.5, 0.5) + 0.1*sin(u_Time/12.5)*(fs_Noise);
    vec3 c = vec3(1.0, 1.0, 1.0) - 0.1*sin(u_Time/10.0)*(fs_Noise);
    vec3 d = vec3(0.00, 0.33, 0.66) + 0.5*sin(u_Time/7.5)*(fs_Noise);
    out_Col = a + b * cos(2 * 3.14159 * (c * t + d));

}
