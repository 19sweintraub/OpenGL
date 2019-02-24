#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float worleyNoise(float scale, float lum) {
    vec2 st = fs_UV * scale;
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);
    float m_dist = lum;

    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(x),float(y));

            // Random position from current + neighbor place in the grid
            vec2 point = random2(i_st + neighbor);

            // Vector between the pixel and the point
            vec2 diff = neighbor + point - f_st;

            // Distance to the point
            float dist = length(diff);

            // Keep the closer distance
            m_dist = min(m_dist, dist);
        }
    }

    return m_dist;
}

void main()
{
    // TODO Homework 5
    color = texture(u_RenderedTexture, fs_UV).rgb;
    float lum = color.r * 0.21 + color.g * 0.71 + color.b * 0.07;
    float dist = worleyNoise(10.0 + 160.0*(1-sin(u_Time/500.0)*sin(u_Time/200.0)), lum);
    if (dist < lum) {
        color = vec3(1, 1, 1);
    }
    else {
        color = vec3(0, 0, 0);
    }

}
