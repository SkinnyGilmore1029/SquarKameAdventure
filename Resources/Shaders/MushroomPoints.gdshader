shader_type canvas_item;

void vertex() {
	float top_influence = 1.0 - UV.y;
	VERTEX.x += sin(TIME * 2.0)  * top_influence;
}

void fragment() {
	vec4 my_blue = vec4(0.373,0.804,0.894, 1.0);
	COLOR = texture(TEXTURE, UV) * my_blue;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
