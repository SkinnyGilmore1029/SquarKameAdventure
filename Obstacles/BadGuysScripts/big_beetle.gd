extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var death_poly: CollisionPolygon2D = $DeathCollision/DeathCollisionPoly
@onready var wall_collision: CollisionShape2D = $WallCollision

var last_direction: String = "left"

func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)

	if collision:
		handle_collision(collision)

		handle_direction()


func _on_speed_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
	handle_direction()

func handle_collision(collider: KinematicCollision2D) -> void:
	var wall_normal: Vector2 = collider.get_normal()

	if velocity.dot(wall_normal) < 0.0:
		velocity = velocity.bounce(wall_normal)
		global_position += wall_normal * 2.0

func handle_direction() -> void:
	if velocity.length_squared() < 1.0:
		return

	rotation = 0.0
	scale.x = 2 if velocity.x < 0 else -2



func _on_despawn_timer_timeout() -> void:
	velocity = Vector2.ZERO
	queue_free()
