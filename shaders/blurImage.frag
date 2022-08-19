#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float radius;
    vec2 resolution;
};

layout(binding = 1) uniform sampler2D source;

void main() {
    const float PI = 6.28318530718; // Pi*2
    const float directions = 16.0;
    const float quality = 3.0;
    const vec2 radiusCalc = radius / resolution.xy;
    const vec2 uv = qt_TexCoord0 / resolution.xy;

    vec4 color = texture(source, uv);
    for (float d = 0.0; d < PI; d+=PI / directions) {
        for (float i = 1.0 / quality; i <= 1.0; i+= 1.0 / quality) {
            color += texture(source, uv + vec2(cos(d), sin(d)) * radiusCalc * i);
        }
    }

    color /= quality * directions - 15.0;
    fragColor = color;
}
