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

void main() {
    const float PI2 = 6.28318530718;
    const vec2 resolution = vec2(width, height);
    const vec2 radiusCalc = radius / resolution.xy;

    vec4 color = texture(source, qt_TexCoord0);
    for (float d = 0.0; d < PI2; d += PI2 / direction) {
        for (float i = 1.0 / quality; i <= 1.0; i += 1.0 / quality) {
            color += texture(source, qt_TexCoord0 + vec2(cos(d), sin(d)) * radiusCalc * i);
        }
    }

    color /= quality * direction - 15.0;
    fragColor = color;
}
