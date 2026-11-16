extends Node2D


@export var level_data: LevelDataManager
@onready var bad_guys_node = %Level1_BadGuys
@onready var hint_frog_text := $Helpful/HintFrog/HintPanel/Label
@onready var hint_frog2_text := $Helpful/HintFrog2/HintPanel/Label
@onready var hint_frog3_text := $Helpful/HintFrog3/HintPanel/Label
@onready var hint_frog4_text := $Helpful/HintFrog4/HintPanel/Label


func _ready() -> void:
	set_level_data()

	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)


func set_level_data() -> void:
	hint_frog_text.text = "You will need to find the keys\nin each level to continue!\n"
	hint_frog2_text.text = "Collecting fruit will give you points!\n Every 800 points will earn you a One-Up!\n"
	hint_frog3_text.text = "The locks will save your progress in the levels!\nBut you have to open them first!\n"
	hint_frog4_text.text = "There are Gold Coins hidden in every level!\n They are not easy to get though.\n"
	level_data.enemy_types = ["Car", "Car2", "Truck", "Bus"]
	level_data.spawn_positions = {
	"Car": [Vector2(1300, 526), Vector2(-100,322), Vector2(1325, -304), Vector2(-233, -525)],
	"Car2" : [Vector2(1300, 526), Vector2(-100,322), Vector2(1325, -304), Vector2(-233, -525)],
	"Truck": [Vector2(1325, -304), Vector2(-233, -525)],
	"Bus": [Vector2(-233, -525)]
	}
	level_data.speed_choices = {
	"Car" : [250, 300, 350],
	"Car2" :[260, 310, 360],
	"Truck" : [150, 200, 220],
	"Bus" : [175, 195, 215]
	}
