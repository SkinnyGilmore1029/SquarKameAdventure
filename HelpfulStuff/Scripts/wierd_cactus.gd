extends CharacterBody2D



func _on_spawn_fly_area_body_entered(body: Node2D) -> void:
	if body is MainKame:
		print("what up")
		print(self.name)

