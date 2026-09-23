class_name LevelSelectControl
extends Control

func _ready():
	%Level2Button.grab_focus()

#Level buttons will first load main game scene
#the


func _on_level_2_button_pressed() -> void:
	GameState.current_level = 2
	GameState.picking_level = true
	get_tree().change_scene_to_file("res://UI_Screens/Screens/KameSelect.tscn")

func _on_level_3_button_pressed() -> void:
	GameState.current_level = 3
	GameState.picking_level = true
	get_tree().change_scene_to_file("res://UI_Screens/Screens/KameSelect.tscn")

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI_Screens/Screens/TitleScreen.tscn")



