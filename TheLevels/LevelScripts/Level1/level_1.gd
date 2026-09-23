class_name Level1Manager
extends Node2D


@export var level_data: LevelDataManager
@onready var bad_guys_node = %Level1_BadGuys
@onready var hint_frog_text := $Helpful/HintFrog/HintPanel/Label


func _ready() -> void:
	set_level_data()

	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)


func set_level_data() -> void:
	hint_frog_text.text = "Find the Key to\n advance to the\n next area."
	level_data.enemy_types = ["Car", "Truck", "Bus"]
	level_data.spawn_positions = {
	"Car": [Vector2(1300, 526), Vector2(-100,322)],
	"Truck": [Vector2(1325, -304)],
	"Bus": [Vector2(-233, -510)]
	}
	level_data.speed_choices = {
	"Car" : [250, 300, 350],
	"Truck" : [150, 200, 220],
	"Bus" : [100, 125, 175]
	}
