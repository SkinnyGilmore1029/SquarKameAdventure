extends Node2D

@export var level_data: LevelDataManager

@onready var hint_frog := $Hints/HintFrog/HintPanel/Label
@onready var hint_frog2 := $Hints/HintFrog2/HintPanel/Label

func _ready() -> void:
	set_level()

func set_level()->void:
	#level_data.heat_timer = 100.0
	hint_frog.text = "The Lizard holds the key.\nBeware of the Scorpions!\n"
	hint_frog2.text = "Its is very hot here.\nFind \bPuddles\b to cool down!\n"
	SignalHub.start_hot_bar.emit(100.0)
