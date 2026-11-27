shader_type canvas_item;
 
const float float_strength = 0.04;
const float float_speed = 0.9;

void vertex() {
	float movement = sin(TIME * float_speed);

	VERTEX.y += movement
		* (1.0 / TEXTURE_PIXEL_SIZE.y)
		* float_strength;
}
