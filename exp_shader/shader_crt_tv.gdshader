shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform float tubing : hint_range(0.0, 1.0, 0.01) = 0.25;

vec2 curve(vec2 uv)
{
	uv = (uv - 0.5) * 2.0;
	uv *= 1.1;
	uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
	uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
	uv  = (uv / 2.0) + 0.5;
	uv =  uv *0.92 + 0.04;
	return uv;
}

void fragment() {
	vec2 tube_distort = (vec2(1.0) - sin(UV.xy * PI)) * tubing;
	vec2 tube_scale = vec2(1.0) + tube_distort * 2.0;

	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 q = FRAGCOORD.xy / iResolution.xy;
    vec2 uv = q;
	vec2 uv_result = SCREEN_UV * tube_scale - tube_distort;
	uv_result = curve(SCREEN_UV);

	if (uv.x >= 0.0 && uv.x <= 1.0
		|| uv.y >= 0.0 && uv.y <= 1.0)
	{
		COLOR = texture(SCREEN_TEXTURE, uv_result);
	}
	else
	{
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}
