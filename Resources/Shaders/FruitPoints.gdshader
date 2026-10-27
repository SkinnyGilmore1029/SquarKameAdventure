shader_type canvas_item;

void vertex() {
	float top_influence = 1.0 - UV.x;
	VERTEX.y += sin(TIME) * 4.0  * top_influence;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
