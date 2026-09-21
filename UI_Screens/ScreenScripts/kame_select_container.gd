extends PanelContainer


func _ready() -> void:
	%PurpleKameButton.grab_focus()


func Purple_button_pressed() -> void:
	GameState.selected_kame = "Purple"
	get_tree().change_scene_to_file("res://MainGame.tscn")
	print("picked purple")
	print(GameState.selected_kame)

func Orange_button_pressed() -> void:
	GameState.selected_kame = "Orange"
	get_tree().change_scene_to_file("res://MainGame.tscn")
	print("picked orange")
	print(GameState.selected_kame)

func Green_button_pressed() -> void:
	GameState.selected_kame = "Green"
	get_tree().change_scene_to_file("res://MainGame.tscn")
	print("picked green")
	print(GameState.selected_kame)
