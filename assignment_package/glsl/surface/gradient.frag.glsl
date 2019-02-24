#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec4 fs_Nor;
in vec4 fs_LightVec;

layout(location = 0) out vec3 out_Col;

void main()
{
    // Calculate the diffuse term for Lambert shading
    float t = dot(normalize(fs_Nor), normalize(fs_LightVec));
    // Avoid negative lighting values
    t = clamp(t, 0, 1);

    // color pallete taken from http://www.iquilezles.org/www/articles/palettes/palettes.htm
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(2.0, 1.0, 1.0);
    vec3 d = vec3(0.50, 0.20, 0.25);

    out_Col = a + b * cos(2 * 3.14159 * (c * t + d));

}
