#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float amount;
uniform float pixel;

vec2 PincushionDistortion(in vec2 uv, float strength) {
	vec2 st = uv - 0.5;
	float uvA = atan(st.x, st.y);
	float uvD = dot(st, st);
	return 0.5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

void main() {
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;

vec2 iResolution = openfl_TextureSize;

  vec2 uv = openfl_TextureCoordv.xy;
  vec2 pixelScale = openfl_TextureSize.xy / pixel;
  uv = amount != 0.0 ? PincushionDistortion(uv, amount) : uv;
  uv = pixel > 0.0 ? floor(uv * pixelScale) / pixelScale : uv;
  if (any(lessThan(uv, vec2(0.0))) || any(greaterThan(uv, vec2(1.0)))) {discard;}
  gl_FragColor = texture2D(bitmap, uv);
}