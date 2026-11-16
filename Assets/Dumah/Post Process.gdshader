shader_type spatial;
render_mode unshaded, fog_disabled;

global uniform vec2 Resolution;
global uniform float ColorDepth;

uniform sampler2D Screen_Texture: hint_screen_texture, filter_nearest;
uniform float dither: hint_range(0.0, 1.0, 0.01) = 0.5;

const mat4 Matrix = (1.0 / 16.0) * mat4(
 vec4(0.0, 8.0, 2.0, 10.0),
 vec4(12.0, 4.0, 14.0, 6.0),
 vec4(3.0, 11.0, 1.0, 9.0),
 vec4(15.0, 7.0, 13.0, 9.0)
) - 0.5;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec2 uv = floor(SCREEN_UV * Resolution) / Resolution;
	ivec2 int_uv = ivec2(uv * Resolution);
	vec3 color = texture(Screen_Texture, uv).rgb;
	vec3 dithered = color + Matrix[int_uv.x % 4][int_uv.y % 4] / ColorDepth * dither;
	vec3 quantized = round(dithered * ColorDepth) / ColorDepth;
	ALBEDO = quantized;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
