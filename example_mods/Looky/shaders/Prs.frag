//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
//SHADERTOY PORT FIX

// Declarar el uniform para depth
uniform float depth;

void mainImage(void)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Usar depth si tiene valor, sino usar 2.5 por defecto
    float finalDepth = (depth != 0.0) ? depth : 2.5;
    
    float dx = distance(uv.x, .5f);
    float dy = distance(uv.y, .5f);
    
    float offset = (dx*.2) * dy;
    
    float dir = 0.;
    if (uv.y <= .5) 
        dir = 1.0;
    else
        dir = -1.;
    
    vec2 coords = vec2(uv.x, uv.y + dx*(offset*finalDepth*dir));
    
    vec2 nuv = coords;
    
    fragColor = texture(iChannel0, nuv); 
}