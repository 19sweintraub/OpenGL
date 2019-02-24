#version 150

in vec2 fs_UV;
out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

void main()
{
    // TODO Homework 5
    mat3 hKernel = mat3(vec3(3, 10, 3), vec3(0, 0, 0), vec3(-3, -10, -3));
    mat3 vKernel = mat3(vec3(3, 0, -3), vec3(10, 0, -10), vec3(3, 0, -3));

    // look at surrounding pixels
    vec3 hGrad = vec3(0);
    vec3 vGrad = vec3(0);
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {

            // convert to pixel space
            int x = int(fs_UV[0] * u_Dimensions[0]);
            int y = int(fs_UV[1] * u_Dimensions[1]);
            vec3 colorSamp = texelFetch(u_RenderedTexture, ivec2(x, y) + ivec2(i-1, j-1), 0 ).rgb;
            hGrad += hKernel[i][j]*colorSamp;
            vGrad += vKernel[i][j]*colorSamp;
        }
    }

    // set color to gradient
    color = sqrt(vGrad*vGrad + hGrad*hGrad);
}
