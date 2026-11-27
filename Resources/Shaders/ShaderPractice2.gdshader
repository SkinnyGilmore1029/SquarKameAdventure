shader_type canvas_item;

uniform float idk_test: hint_range(0,1.0);
uniform sampler2D test_texture;

void vertex() {
	float sway = sin(TIME *2.0);
	VERTEX.x += sway * 2.0 * (1.0 - UV.y);
}

void fragment() {
	float diagonal = (UV.x + UV.y)/2.0;
	COLOR.a *= step(idk_test, diagonal);
}
