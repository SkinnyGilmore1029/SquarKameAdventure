extends PanelContainer


func _ready() -> void:
	%PurpleKameButton.grab_focus()


func Purple_button_pressed() -> void:
	GameState.selected_kame = "Purple"
	get_tree().change_scene_to_file(GameState.main_scene)

func Orange_button_pressed() -> void:
	GameState.selected_kame = "Orange"
	get_tree().change_scene_to_file(GameState.main_scene)

func Green_button_pressed() -> void:
	GameState.selected_kame = "Green"
	get_tree().change_scene_to_file(GameState.main_scene)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.difficulty_screen)
