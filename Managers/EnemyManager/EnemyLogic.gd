class_name EnemyLogic
extends CharacterBody2D


@export var enemy_data: EnemyData




@onready var vehicle_speed = enemy_data.speed

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if self.global_position.x < 0:
		direction = Vector2.RIGHT
		self.scale.x = -1
		if enemy_data.enemy_type == "Bus":
			self.scale.x = 1
	else:
		direction = Vector2.LEFT
		self.scale.x = 1


func _physics_process(delta: float) -> void:
	velocity = direction * enemy_data.speed
	move_and_slide()
