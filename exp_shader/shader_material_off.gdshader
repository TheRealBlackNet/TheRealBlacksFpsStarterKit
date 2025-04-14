shader_type canvas_item;
// skip_vertex_transform - did not move the quad
render_mode unshaded;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
}
