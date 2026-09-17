class_name LevelSelectControl
extends Control

func _ready():
	%BackButton.grab_focus()

#Level buttons will first load main game scene
#the

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI_Screens/Screens/TitleScreen.tscn")
