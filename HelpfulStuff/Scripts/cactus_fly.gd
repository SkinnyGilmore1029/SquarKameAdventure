class_name TheFlies
extends CharacterBody2D


var speed_x: float
var speed_y: float
var new_x: float
var new_y: float



func _ready() -> void:
	speed_x = randf_range(-150,150)
	speed_y = randf_range(-150,150)
	var rand_x: float = randf_range(-150,150)
	var rand_y: float = randf_range(-150,150)

	new_x = speed_x - rand_x
	new_y = speed_y - rand_y


	velocity = Vector2(new_x, new_y)


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)

	if collision:
		var wall_normal := collision.get_normal()
		velocity = velocity.bounce(wall_normal)
		global_position += wall_normal * 1.0


func _on_timer_timeout() -> void:
	speed_x = randf_range(-150,150)
	speed_y = randf_range(-150,150)
	var rand_x: float = randf_range(-50,50)
	var rand_y: float = randf_range(-50,50)

	new_x = speed_x + rand_x
	new_y = speed_y + rand_y

	velocity = Vector2(new_x, new_y)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		SignalHub.collected_fly.emit(self.name)
		queue_free()

