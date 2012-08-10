
attribute vec4 Position;
attribute vec4 Color;

varying vec4 DestColor;

void main(void)
{
    DestColor = Color;
    gl_Position = Position;
}