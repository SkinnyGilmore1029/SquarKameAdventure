class_name GameOver
extends Control

var Roll_back_dict: Dictionary = {
	"Easy" : 99,
	"Normal" : 10,
	"Hard" : 3,
	"Insane" : 1
}

var main_scene: StringName = "res://MainGame.tscn"
var title_scene: StringName = "res://UI_Screens/Screens/TitleScreen.tscn"

func _ready() -> void:
	%ContinueButton.grab_focus()

func _on_continue_button_pressed() -> void:
	if GameState.difficulty_selected not in Roll_back_dict:
		push_warning("%s not in Roll back game_over.gd." % GameState.difficulty_selected)
		PlayerGlobals.players_lives = 10
		GameState.current_level = 1
		GameState.continuing_from_game_over = true
		get_tree().change_scene_to_file(main_scene)
		return

	PlayerGlobals.players_lives = Roll_back_dict.get(GameState.difficulty_selected)

	GameState.continuing_from_game_over = true


	get_tree().change_scene_to_file(main_scene)


func _on_title_screen_button_pressed() -> void:
	if PlayerGlobals.speed == 180.0:
		PlayerGlobals.speed = PlayerGlobals.default_speed
	get_tree().change_scene_to_file(title_scene)

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
