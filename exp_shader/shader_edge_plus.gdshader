shader_type canvas_item;
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;
const float size = 5.0;

// loop makes the skinny line fat, its a blur with a hard step up
void fragment() {
	float mean = 0.0;
	float diff = 0.0;
	for (float x = -size; x < size; x++)
	{
		for (float y = -size; y < size; y++)
		{
			diff = (texture(SCREEN_TEXTURE, 
					SCREEN_UV - vec2(
						-SCREEN_PIXEL_SIZE.x*x, 
						SCREEN_PIXEL_SIZE.y*y)).rgb
			   	- texture(SCREEN_TEXTURE, 
					SCREEN_UV  - vec2(
						SCREEN_PIXEL_SIZE.x*x, 
						-SCREEN_PIXEL_SIZE.y*y)).rgb).s;
			diff = step(0.25, diff);
			mean += diff;
		}
	}
	diff = mean;
	diff = step(0.25, diff);
	COLOR = vec4(diff, diff, diff, 1.0);
}
