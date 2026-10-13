extends CharacterBody2D

var has_all_flies: bool = false

func _process(delta: float) -> void:
	if self.has_all_flies:
		self.move_lizard()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		%FlyCountContainer.visible = true



func _on_body_collision_body_exited(body: Node2D) -> void:
	if body is MainKame:
		%FlyCountContainer.visible = false


func has_flies() -> void:
	self.has_all_flies = true

func move_lizard() -> void:
	match self.name:
		"Lizard":
			if global_position.y <= 1:
				global_position.y = 1
				velocity = Vector2.ZERO
			else:
				velocity = Vector2(0, -100)

		"Lizard2":
			if global_position.y <= 1634:
				global_position.y = 1634
				velocity = Vector2.ZERO
			else:
				velocity = Vector2(0, -100)
	move_and_slide()