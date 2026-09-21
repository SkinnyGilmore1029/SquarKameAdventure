class_name TitleButtonsControl
extends Control

var last_screen: String = "New"

#this might be able to work if I can think of a way to hold global var.
#BUT the I also want the game to start up on New Game. This just over writes current way.
#Maybe make the title screen a node of a Main Title screen hub lol.
#switch nodes out like i do levels and hold variable on parent that stays??:S
func _ready() -> void:
	match last_screen:
		"New":
			%NewGameButton.grab_focus()
		"Level Select":
			%LevelSelectButton.grab_focus()
		"Options":
			%OptionsButton.grab_focus()

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI_Screens/Screens/KameSelect.tscn")

func _on_level_select_button_pressed() -> void:
	last_screen = "Level Select"
	get_tree().change_scene_to_file("res://UI_Screens/Screens/LevelSelect.tscn")

func _on_options_button_pressed() -> void:
	last_screen = "Options"
	get_tree().change_scene_to_file("res://UI_Screens/Screens/OptionsScreen.tscn")

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()



