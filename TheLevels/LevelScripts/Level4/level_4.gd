extends Node2D

@export var level_data: LevelDataManager

@onready var hint_frog := $Hints/HintFrog/HintPanel/Label
@onready var hint_frog2 := $Hints/HintFrog2/HintPanel/Label
@onready var bad_guy_node = get_node("Level4_BadGuys/Respawning")

func _ready() -> void:
	set_level()
	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)

func set_level()->void:
	#level_data.heat_timer = 100.0
	hint_frog.text = "The Lizard holds the key.\nBeware of the Scorpions!\n"
	hint_frog2.text = "Its is very hot here.\nFind \bPuddles\b to cool down!\n"
	level_data.enemy_types = ["Tornado"]
	level_data.spawn_positions = {
		"Tornado" : [
			Vector2(-37,1583),
			Vector2(-1038,878),
			Vector2(-1700,1637)
			]
	}
	level_data.speed_choices = {
		"Tornado" : [250, 300, 350]
	}
	SignalHub.start_hot_bar.emit(100.0)


func _on_spawn_tornado_timeout() -> void:
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)
