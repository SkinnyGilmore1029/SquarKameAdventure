extends CharacterBody2D

@export var enemy_data: EnemyData

func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed,y_speed)

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)

	if collision:
		var wall_normal := collision.get_normal()
		velocity = velocity.bounce(wall_normal)
		global_position += wall_normal * 1.0


func _on_de_spawn_timer_timeout() -> void:
	queue_free()


func _on_speed_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
