class_name FlyResource
extends Resource

@export var offset_vector: Vector2 = Vector2(50,100)




func create_spawn_vector(cactus_x: float, cactus_y: float) -> Vector2:
	var random_x: float = randf_range(
		offset_vector.x,
		offset_vector.y
		)

	var random_y: float = randf_range(
		offset_vector.x,
		offset_vector.y
		)
	var new_x_pos: float = cactus_x + random_x

	var new_y_pos: float = cactus_y + random_y

	return Vector2(new_x_pos,new_y_pos)
