#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float radius;
};
layout(binding = 1) uniform sampler2D source;

void main(void)
{
    float blurSize = radius / 1000.0;

    vec4 color = vec4(0.0);
    color += texture(source, qt_TexCoord0 - 4.0 * blurSize) * 0.05;
    color += texture(source, qt_TexCoord0 - 3.0 * blurSize) * 0.09;
    color += texture(source, qt_TexCoord0 - 2.0 * blurSize) * 0.12;
    color += texture(source, qt_TexCoord0 - blurSize) * 0.15;
    color += texture(source, qt_TexCoord0) * 0.16;
    color += texture(source, qt_TexCoord0 + blurSize) * 0.15;
    color += texture(source, qt_TexCoord0 + 2.0 * blurSize) * 0.12;
    color += texture(source, qt_TexCoord0 + 3.0 * blurSize) * 0.09;
    color += texture(source, qt_TexCoord0 + 4.0 * blurSize) * 0.05;

    fragColor = color;
}
