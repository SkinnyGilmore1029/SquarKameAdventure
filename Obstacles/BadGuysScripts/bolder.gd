extends CharacterBody2D

@export var enemy_data: EnemyData

@onready var y_speed: int = enemy_data.speed

func _ready() -> void:
	var x_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)

func _physics_process(delta: float) -> void:
	move_bolder()

func move_bolder() -> void:
	move_and_slide()

func _on_change_xspeed_timeout() -> void:
	var x_speed: int = randi_range((-enemy_data.speed + enemy_data.speed_offset), (enemy_data.speed + enemy_data.speed_offset))
	velocity = Vector2(x_speed, y_speed)
