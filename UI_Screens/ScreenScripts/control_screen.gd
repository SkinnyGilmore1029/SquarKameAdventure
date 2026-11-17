extends Control

func _ready() -> void:
	%BackControlButton.grab_focus()

func _on_back_control_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.title_screen)
