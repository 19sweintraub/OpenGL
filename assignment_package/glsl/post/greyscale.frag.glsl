#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

void main()
{
    // TODO Homework 5
    // Get original frag color
    vec4 colorSample = texture(u_RenderedTexture, fs_UV);

    // Convert to grey scale
    colorSample.r = colorSample.r * 0.21 + colorSample.g * 0.71 + colorSample.b * 0.07;
    colorSample.g = colorSample.r * 0.21 + colorSample.g * 0.71 + colorSample.b * 0.07;
    colorSample.b = colorSample.r * 0.21 + colorSample.g * 0.71 + colorSample.b * 0.07;

    // Find distance for vignette
    float dist = distance(fs_UV, vec2(0.5, 0.5));

    // brightness as a function of dist
    float lightIntensity = clamp(1 - 1.1*sqrt(dist), 0, 1);

    // output color
    color = vec3(colorSample.rgb * lightIntensity);
}
