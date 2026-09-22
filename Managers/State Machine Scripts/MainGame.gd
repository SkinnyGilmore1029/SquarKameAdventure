class_name MainGame
extends Node2D

var kame_selection: Dictionary[String, String] = {
	"Orange" : "res://SquarKames/KamesScenes/OrangeKame.tscn",
	"Green" : "res://SquarKames/KamesScenes/SquarKame.tscn",
	"Purple" : "res://SquarKames/KamesScenes/PurpleKame.tscn"
}

@onready var player_node: Node2D = $PlayerNode
@onready var music := $TheAudio/BackgroundMusic

func _ready() -> void:
	change_kame()
	music.play()
	if GameState.continuing_from_game_over:
		GameState.continuing_from_game_over = false
		LevelChange.call_deferred(
			"change_level",
			GameState.current_level,
		)
		return
	if GameState.picking_level:
		GameState.picking_level = false
		LevelChange.call_deferred(
			"change_level",
			GameState.current_level,
		)
		return
	#Just in case you game over on level 1.
	GameState.current_level = 1

func change_kame()-> void:
	var kame_selected = GameState.selected_kame
	#check dictionary first.
	#if kame not in the dictionary default to the green one.
	if kame_selected not in kame_selection:
		kame_selected = "Green"

	#make sure only one Kame is in the Game.
	if player_node.get_child_count() > 0:
		player_node.get_child(0).queue_free()

	var kame_scene := load(kame_selection[kame_selected])
	var kame_instance = kame_scene.instantiate()
	player_node.add_child(kame_instance)
