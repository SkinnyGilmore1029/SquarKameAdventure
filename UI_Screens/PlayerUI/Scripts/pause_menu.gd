extends Control

var player_node: Node2D
var kame_playing: MainKame
var current_menu: String = "PauseMenu"

#------------------Main Process Functions------------------#
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing = await get_kame_playing()
	SignalHub.focus_continue_button.connect(grab_continue_button_focus)


func _process(_delta:float) -> void:
	if GameInput.pause_game():
		open_pause_menu()
	if GameInput.back_button_pushed():
		match current_menu:
			"PauseMenu":
				close_pause_menu()
			"PausedOptions":
				SignalHub.hide_paused_options.emit()
				get_parent().visible = true
				current_menu = "PauseMenu"
				GameState.from_pause_menu = false
			_:
				unknown_close_pause_menu()

#------------------Pause Menu Functions------------------#
func get_kame_playing() -> MainKame:
	await get_tree().process_frame

	player_node = get_tree().get_current_scene().get_node("PlayerNode")

	if player_node.get_child_count() <= 0:
		push_warning("No Kame found in PlayerNode. Please check the Main scene tree.")
		return null

	return player_node.get_child(0) as MainKame

func open_pause_menu() -> void:
	%ContinueButton.grab_focus()
	get_parent().visible = true
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_DISABLED
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = true

func close_pause_menu() -> void:
	get_tree().paused = false
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	get_parent().visible = false

func unknown_close_pause_menu() -> void:
	SignalHub.hide_paused_options.emit()
	SignalHub.hide_pause_menu.emit()
	GameState.from_pause_menu = false
	get_tree().paused = false
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	push_warning("Unknown menu state: %s" % current_menu)

func reset_pause_menu() -> void:
	current_menu = "PauseMenu"

#------------------Button Functions------------------#


func _on_continue_button_pressed() -> void:
	close_pause_menu()


func _on_options_button_pressed() -> void:
	GameState.from_pause_menu = true
	SignalHub.hide_pause_menu.emit()
	SignalHub.show_paused_options.emit()
	current_menu = "PausedOptions"


func _on_title_button_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	reset_everything()
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	tree.change_scene_to_file(GameState.title_screen)

func grab_continue_button_focus() -> void:
	%ContinueButton.grab_focus()

func reset_everything() -> void:
	GameState.from_pause_menu = false
	AudioBus.background_music.stop()
	Points.current_score = 0
	Points.life_points = 0
	current_menu = "PauseMenu"