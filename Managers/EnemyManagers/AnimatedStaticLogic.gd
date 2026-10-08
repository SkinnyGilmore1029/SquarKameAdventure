extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

#starts initial movement.
func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		handle_collision(collision)

	handle_direction()

func handle_collision(collider: KinematicCollision2D) -> void:
	var wall_normal := collider.get_normal()
	velocity = velocity.bounce(wall_normal)
	global_position += wall_normal * 1.0

func handle_direction() -> void:
	if velocity == Vector2.ZERO:
		return

	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			animation.play("right")
		else:
			animation.play("left")
	else:
		if velocity.y > 0:
			animation.play("down")
		else:
			animation.play("up")

func _on_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
