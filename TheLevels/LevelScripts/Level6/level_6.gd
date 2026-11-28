extends Node2D

@export var level_data: LevelDataManager

@onready var bad_guys_node = $Level6_BadGuys/Respawning
@onready var hint_frog_text: = $Helpful/Hints/HintFrog/HintPanel/Label

@onready var big_beetle_spawns: Array[Vector2] = [
	%BigBeetleSpawn2.position,
	%BigBeetleSpawn5.position,
	%BigBeetleSpawn6.position,
	%BigBeetleSpawn7.position,
	%BigBeetleSpawn8.position,
]


func _ready() -> void:
	set_level_data()
	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)

func set_level_data() -> void:
	hint_frog_text.text = "Still building\nthis Level6!"
	level_data.enemy_types = ["BigBeetle"]
	level_data.spawn_positions = {
		"BigBeetle" : big_beetle_spawns,
	}
	level_data.speed_choices = {
		"BigBeetle"  : [120, 140, 160]
	}
