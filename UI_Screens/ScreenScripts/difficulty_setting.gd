class_name DifficultySettings
extends Control


func _ready() -> void:
	%NormalButton.grab_focus()

func _on_easy_button_pressed() -> void:
	PlayerGlobals.players_lives = 99
	SignalHub.one_up_collected.emit(PlayerGlobals.players_lives)
	GameState.difficulty_selected = "Easy"
	get_tree().change_scene_to_file(GameState.character_select)

func _on_normal_button_pressed() -> void:
	PlayerGlobals.players_lives  = 10
	SignalHub.one_up_collected.emit(PlayerGlobals.players_lives)
	GameState.difficulty_selected = "Normal"
	get_tree().change_scene_to_file(GameState.character_select)

func _on_hard_button_pressed() -> void:
	PlayerGlobals.players_lives  = 3
	SignalHub.one_up_collected.emit(PlayerGlobals.players_lives)
	GameState.difficulty_selected = "Hard"
	get_tree().change_scene_to_file(GameState.character_select)

func _on_insane_button_pressed() -> void:
	PlayerGlobals.players_lives = 1
	SignalHub.one_up_collected.emit(PlayerGlobals.players_lives)
	PlayerGlobals.speed = 180.0
	GameState.difficulty_selected = "Insane"
	get_tree().change_scene_to_file(GameState.character_select)


func _on_insane_button_focus_entered() -> void:
	%InsaneWarning.visible = true


func _on_insane_button_focus_exited() -> void:
	%InsaneWarning.visible = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(GameState.title_screen)
