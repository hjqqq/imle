
attribute vec4 Position;
attribute vec4 Color;

varying vec4 DestColor;

uniform mat4 Projection;

void main(void)
{
    DestColor = Color;
    gl_Position = Projection * Position;
}