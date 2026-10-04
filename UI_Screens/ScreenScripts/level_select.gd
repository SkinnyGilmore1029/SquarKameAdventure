class_name LevelSelectControl
extends Control


func _ready():
	%Level2Button.grab_focus()

#Level buttons will first load main game scene
#the

func _on_level_2_button_pressed() -> void:
	set_game_state(2)

func _on_level_3_button_pressed() -> void:
	set_game_state(3)

func _on_level_4_button_pressed() -> void:
	set_game_state(4)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.title_screen)




# so i don't have to repeat this code in each button function i will make a function that takes the level number as an argument and sets the game state and changes the scene to the difficulty screen.
func set_game_state(level:int) -> void:
	GameState.current_level = level
	GameState.picking_level = true
	get_tree().change_scene_to_file(GameState.difficulty_screen)