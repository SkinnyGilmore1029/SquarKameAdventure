class_name MainGame
extends Node2D

var kame_selection: Dictionary[String, String] = {
	"Orange" : "res://SquarKames/KamesScenes/OrangeKame.tscn",
	"Green" : "res://SquarKames/KamesScenes/SquarKame.tscn",
	"Purple" : "res://SquarKames/KamesScenes/PurpleKame.tscn"
}

@onready var player_node: Node2D = $PlayerNode

@onready var music := $TheAudio/BackgroundMusic
@onready var screen_transitions: Node = $ScreenTranstion

func _ready() -> void:
	var coming_from_game_over: bool = GameState.continuing_from_game_over
	var coming_from_picking_level: bool = GameState.picking_level
	check_game_over()
	picking_level()
	#Player node is load here before pausing.
	change_kame()
	#Just in case you game over on level 1.
	GameState.current_level = 1
	if not coming_from_game_over and not coming_from_picking_level:
		var tree = get_tree()
		var kame_playing = player_node.get_child(0) as MainKame
		await tree.process_frame
		kame_playing.state_machine.process_mode = Node.PROCESS_MODE_DISABLED
		kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_DISABLED
		tree.paused = true
		screen_transitions.set_labels(GameState.current_level)
		await screen_transitions.call_deferred("fade_out")

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

func check_game_over() -> void:
	if GameState.continuing_from_game_over:
		GameState.continuing_from_game_over = false
		LevelChange.call_deferred(
			"change_level",
			GameState.current_level,
		)
		return

func picking_level()-> void:
	if GameState.picking_level:
		GameState.picking_level = false
		LevelChange.call_deferred(
			"change_level",
			GameState.current_level,
		)
		return