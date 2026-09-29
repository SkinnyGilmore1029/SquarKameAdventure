class_name TitleButtonsControl
extends Control

func _ready() -> void:
	%NewGameButton.grab_focus()

func _on_new_game_button_pressed() -> void:
	GameState.current_level = 1
	get_tree().change_scene_to_file(GameState.difficulty_screen)

func _on_level_select_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.level_select)

func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.option_screen)

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()



