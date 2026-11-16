extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	%MainVolume.grab_focus()
	SignalHub.focus_volume_slider.connect(get_slider)

func _process(_delta:float) -> void:
	check_if_from_pause_menu()

func get_slider() -> void:
	%MainVolume.grab_focus()

func check_if_from_pause_menu() -> void:
	if GameState.from_pause_menu:
		%BackPauseButton.visible = true
		%BackButton.visible = false
	else:
		%BackPauseButton.visible = false
		%BackButton.visible = true

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI_Screens/Screens/TitleScreen.tscn")

func _on_back_pause_button_pressed() -> void:
	SignalHub.hide_paused_options.emit()
	SignalHub.show_pause_menu.emit()
	GameState.from_pause_menu = false


func _on_main_volume_value_changed(value: float) -> void:
	var main_volume_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(main_volume_index, value)

func _on_background_music_value_changed(value: float) -> void:
	var bg_volume_index = AudioServer.get_bus_index("BackGround")
	AudioServer.set_bus_volume_db(bg_volume_index, value)

func _on_sound_effects_value_changed(value: float) -> void:
	var  sfx_volume_index = AudioServer.get_bus_index("SoundEffects")
	AudioServer.set_bus_volume_db(sfx_volume_index, value)
