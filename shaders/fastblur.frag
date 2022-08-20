#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float width;
    float height;
    float radius;
    float direction;
    float quality;
};
layout(binding = 1) uniform sampler2D source;

float blurWeight(float x, float sigma) {
    return exp(-0.5 * (x * x) / (sigma * sigma));
}

vec4 blur(sampler2D source, vec2 direction, vec2 coord, int steps, vec2 blurRange, float sigma) {
    vec4 total = vec4(0.0);

    float totalWeight = 0.0;

    for (int step = -steps; step <= steps; ++step) {
        vec2 texCoord = coord + direction * float(step) / float(steps) * blurRange;
        float weight = blurWeight(float(step) / float(steps), sigma);
        total += weight * texture(source, texCoord);
        totalWeight += weight;
    }

    return total / totalWeight;
}

void main(void)
{
    const vec2 resolution = vec2(width, height);
    vec4 color = vec4(0.0);

    color += blur(source, vec2(0.25, 0.25), qt_TexCoord0, int(direction), radius / resolution.xy, quality);

    fragColor = color;
}
