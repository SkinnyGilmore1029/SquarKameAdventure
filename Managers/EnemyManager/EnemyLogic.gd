class_name EnemyLogic
extends CharacterBody2D


@export var enemy_data: EnemyData
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var vehicle_speed = enemy_data.speed

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	if self.global_position.x < 0:
		direction = Vector2.RIGHT
		animated_sprite.flip_h = true
		if enemy_data.enemy_type == "Bus":
			animated_sprite.flip_h = false
	else:
		direction = Vector2.LEFT
		animated_sprite.flip_h = false
		if enemy_data.enemy_type == "Truck":
			animated_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	#if enemy_data.is_dead:
		#queue_free()
	velocity = direction * enemy_data.speed
	move_and_slide()
