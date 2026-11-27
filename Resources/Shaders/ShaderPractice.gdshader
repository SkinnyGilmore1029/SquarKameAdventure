shader_type canvas_item;

uniform float size: hint_range(0.0, 0.5);
uniform vec3 color: source_color;

void vertex(){
	//
}

void fragment() {
	float circle = distance(UV, vec2(0.5));
	COLOR.a  = 1.0 - step(size, circle);
	COLOR.rgb = color;
	
}
