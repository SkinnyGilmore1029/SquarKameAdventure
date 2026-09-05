class_name Level1Manager
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
	"Car": [Vector2(1300, 526), Vector2(-100,322)],
	"Truck": [Vector2(1325, -304)],
	"Bus": [Vector2(-233, -510)]
	}
	level_data.speed_choices = {
	"Car": [200, 250, 300],
	"Truck": [150, 200, 220],
	"Bus": [75, 100, 150]
	}
