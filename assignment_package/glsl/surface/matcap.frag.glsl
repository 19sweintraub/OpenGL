#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec2 fs_UV;
in vec4 fs_Nor;


layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4

    float x = fs_Nor[0];
    float y = fs_Nor[1];

    vec2 location = vec2( (x*sqrt(1 - y*y /2) + 1) /2, (y*sqrt(1 - x*x /2)+1) / 2);

    vec4 color = texture(u_Texture, location);

    out_Col = vec3(color.rgb);
}
