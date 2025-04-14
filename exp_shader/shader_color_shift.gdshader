shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;
uniform float moved_u : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float moved_v : hint_range(0.0, 1.0, 0.01) = 0.0;

void fragment() {
	vec4 orig = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 moved_r = texture(SCREEN_TEXTURE, 
			SCREEN_UV - vec2(moved_u, moved_v));
	vec4 moved_b = texture(SCREEN_TEXTURE, 
			SCREEN_UV - vec2(-moved_u, -moved_v));

	COLOR = vec4(moved_r.r, orig.g, moved_b.b, 1.0);
}
