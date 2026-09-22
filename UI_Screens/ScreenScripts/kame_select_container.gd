extends PanelContainer

var go_to: StringName = "res://UI_Screens/Screens/DifficultySetting.tscn"

func _ready() -> void:
	%PurpleKameButton.grab_focus()


func Purple_button_pressed() -> void:
	GameState.selected_kame = "Purple"
	get_tree().change_scene_to_file(go_to)

func Orange_button_pressed() -> void:
	GameState.selected_kame = "Orange"
	get_tree().change_scene_to_file(go_to)

func Green_button_pressed() -> void:
	GameState.selected_kame = "Green"
	get_tree().change_scene_to_file(go_to)

