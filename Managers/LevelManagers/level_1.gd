extends Node2D


@onready var bad_guys_node = %Level1_BadGuys
@export var level_data: LevelDataManager


func _ready() -> void:
	set_level_data()

	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)


func set_level_data() -> void:
	level_data.enemy_types = ["Car", "Truck", "Bus"]
	level_data.spawn_positions = {
	"Car": [Vector2(1300, 320), Vector2(-100,288)],
	"Truck": [Vector2(1300, -588)],
	"Bus": [Vector2(-100, -720)]
	}
	level_data.speed_choices = {
	"Car": [200, 250, 300],
	"Truck": [150, 200],
	"Bus": [100, 150]
	}



func enemy_direction(enemy_type: CharacterBody2D) -> String:
	match enemy_type.name:
		"Car":
			if enemy_type.global_position.x < 0:
				return "Right"
			else:
				return "left"
		"Truck":
			return "left"
		"Bus":
			return "Right"
		_:
			push_warning("Unknown enemy type: %s" % enemy_type)
			return "Right"
