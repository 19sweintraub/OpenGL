#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;
uniform vec2 u_Mouse;

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float worleyNoise(float scale, float lum) {
    vec2 st = fs_UV * scale;
    vec2 gridCord = floor(st);
    vec2 pointCord = fract(st);
    float minDist = lum;

    for (int i= -1; i <= 1; i++) {
        for (int j= -1; j <= 1; j++) {

            // Find neighbor
            vec2 neighbor = vec2(float(j),float(i));

            // generate random point in the cell
            vec2 point = random2(gridCord + neighbor);

            // establish vector between random point and the coordinate
            vec2 diff = neighbor + point - pointCord;

            // Distance to the point
            float dist = length(diff);

            // Keep the closer distance
            if (dist < minDist) {
                minDist = dist;
            }
        }
    }

    return minDist;
}

void main()
{
    // TODO Homework 5

    vec2 mouse = u_Mouse / u_Dimensions;
    mouse[1] = 1 - mouse[1];

    float dist = worleyNoise(200.0, 1.0);
    vec2 new_UV = fs_UV;
    new_UV += 25.0 * (1 + sin(u_Time/100.0)) * dist * normalize(fs_UV - mouse) / u_Dimensions ;
    color = texture(u_RenderedTexture, new_UV).rgb;

}
