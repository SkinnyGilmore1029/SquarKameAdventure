class_name StaticEnemyLogic
extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var picture: AnimatedSprite2D = $AnimatedSprite2D

#starts initial movement.
func _ready() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
	picture.flip_h = velocity.x > 0

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)

	if collision:
		var wall_normal := collision.get_normal()
		velocity = velocity.bounce(wall_normal)
		global_position += wall_normal * 1.0
		picture.flip_h = velocity.x > 0

#randomly changes it every 5 seconds.
func _on_timer_timeout() -> void:
	var x_speed: int = randi_range(-enemy_data.speed, enemy_data.speed)
	var y_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
	picture.flip_h = velocity.x > 0
