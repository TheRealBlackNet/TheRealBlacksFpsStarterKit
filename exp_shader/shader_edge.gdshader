shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

void fragment() {
	float diff = 
		 texture(SCREEN_TEXTURE, 
			SCREEN_UV - vec2(-SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y)).s
	   	- texture(SCREEN_TEXTURE, 
			SCREEN_UV  - vec2(SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y)).s;
	COLOR = vec4(diff, diff, diff, 1.0);
}
