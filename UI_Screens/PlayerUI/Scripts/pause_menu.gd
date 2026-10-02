extends Control

var player_node: Node2D
var kame_playing: MainKame


#------------------Main Process Functions------------------#
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing = await get_kame_playing()

func _process(_delta:float) -> void:
	if GameInput.pause_game():
		open_pause_menu()
	if GameInput.back_button_pushed():
		close_pause_menu()

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
	self.get_parent().visible = true
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_DISABLED
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = true

func close_pause_menu() -> void:
	get_tree().paused = false
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	self.get_parent().visible = false

#------------------Button Functions------------------#


func _on_continue_button_pressed() -> void:
	close_pause_menu()


func _on_options_button_pressed() -> void:
	pass


func _on_title_button_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	tree.change_scene_to_file(GameState.title_screen)
