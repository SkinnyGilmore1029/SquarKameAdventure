class_name SquareCollisionLogic
extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_collision: Area2D = $DeathCollision
@onready var wall_collision: CollisionShape2D = $WallCollision

var current_direction: String = ""

#starts initial movement.
func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
	handle_direction()

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		handle_collision(collision)

func handle_collision(collider: KinematicCollision2D) -> void:
	var wall_normal := collider.get_normal()

	if velocity.dot(wall_normal) >= 0.0:
		return

	# Save the old collision shape orientation.
	var old_position := wall_collision.position

	# Bounce away from the wall.
	velocity = velocity.bounce(wall_normal)

	# Update animation and collision geometry.
	handle_direction()

	# Calculate how far the new shape has moved into the wall.
	# Convert the collider's local offset change to world space. Enemies such as
	# the scorpion are scaled in their scene, so a local-space correction alone
	# would leave the enlarged collider embedded in the wall.
	var position_change := global_transform.basis_xform(wall_collision.position - old_position)

	var push_distance := maxf(
		0.0,
		-position_change.dot(wall_normal)
	)

	# Small additional separation.
	global_position += wall_normal * (push_distance + 2.0)

func handle_direction() -> void:
	if velocity.length_squared() < 1.0:
		return

	var new_direction: String

	if abs(velocity.x) > abs(velocity.y):
		new_direction = "right" if velocity.x > 0 else "left"
	else:
		new_direction = "down" if velocity.y > 0 else "up"

	if new_direction == current_direction:
		return

	current_direction = new_direction

	# Play the corresponding directional animation
	animation.play(current_direction)

	# Update collision geometry to match the animation
	handle_collision_box()

func handle_collision_box() -> void:
	match current_direction:
		"left":
			wall_collision.position = Vector2(6.333, -2.0)
			wall_collision.rotation = deg_to_rad(-90.0)
			death_collision.rotation = deg_to_rad(-90.0)
			death_collision.scale = Vector2(1, 1)

		"right":
			wall_collision.position = Vector2(-6.333, 2.0)
			wall_collision.rotation = deg_to_rad(90.0)
			death_collision.rotation = deg_to_rad(90.0)
			death_collision.scale = Vector2(1, 1)

		"up":
			wall_collision.position = Vector2(2.333, 6.667)
			wall_collision.rotation = 0.0
			death_collision.rotation = 0.0
			death_collision.scale = Vector2(1, 1)

		"down":
			wall_collision.position = Vector2(-2.333, -6.667)
			wall_collision.rotation = 0.0
			death_collision.rotation = 0.0
			death_collision.scale = Vector2(-1, -1)

func _on_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	var new_wait: float = randf_range(1.0, 4.0)
	velocity = Vector2(x_speed, y_speed)
	handle_direction()
	%ScropionTimer.wait_time = new_wait
	%ScropionTimer.start()
