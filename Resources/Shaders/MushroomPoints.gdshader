shader_type canvas_item;

uniform vec4 my_color: source_color;


void vertex() {
	float sway = sin(TIME *4.0);
	VERTEX.x += sway * 2.0 * (0.35 - UV.y);
}

void fragment() {
	COLOR = texture(TEXTURE, UV) * my_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
