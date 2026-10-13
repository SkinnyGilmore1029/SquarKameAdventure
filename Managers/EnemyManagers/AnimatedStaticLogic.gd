extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_collision: Area2D = $DeathCollision
@onready var wall_collision: CollisionShape2D = $WallCollision

#starts initial movement.
func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
	handle_direction()
	handle_collision_box()

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		handle_collision(collision)

		handle_direction()
		handle_collision_box()

func handle_collision(collider: KinematicCollision2D) -> void:
	var sprite_size: Vector2 = animation.sprite_frames.get_frame_texture(
		animation.animation,
		animation.frame
	).get_size()

	var wall_normal := collider.get_normal()

	if velocity.dot(wall_normal) < 0.0:
		velocity = velocity.bounce(wall_normal)

	var push_distance: float

	if abs(wall_normal.x) > 0.0:
		push_distance = sprite_size.x
	else:
		push_distance = sprite_size.y

	global_position += wall_normal * push_distance

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

func handle_collision_box() -> void:
	match animation.animation:
		"left":
			wall_collision.position = Vector2(6.333,-2.0)
			wall_collision.rotation = deg_to_rad(-90.0)
			death_collision.rotation = deg_to_rad(-90.0)
			death_collision.scale = Vector2(1, 1)
		"right":
			wall_collision.position = Vector2(-6.333,2.0)
			wall_collision.rotation = deg_to_rad(90.0)
			death_collision.rotation = deg_to_rad(90.0)
			death_collision.scale = Vector2(1, 1)
		"up":
			wall_collision.position = Vector2(2.333,6.667)
			wall_collision.rotation = deg_to_rad(0.0)
			death_collision.rotation = deg_to_rad(0.0)
			death_collision.scale = Vector2(1, 1)
		"down":
			wall_collision.position = Vector2(-2.333,-6.667)
			wall_collision.rotation = deg_to_rad(0.0)
			death_collision.rotation = deg_to_rad(0.0)
			death_collision.scale = Vector2(-1, -1)
		_:
			pass

func _on_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
