extends CanvasLayer

#Pause menu Options

func _ready() -> void:
	visible = false
	connect_my_signals()


func connect_my_signals() -> void:
	SignalHub.show_paused_options.connect(open_options_menu)
	SignalHub.hide_paused_options.connect(close_options_menu)

func open_options_menu() -> void:
	GameState.from_pause_menu = true
	visible = true
	SignalHub.focus_volume_slider.emit()

func close_options_menu() -> void:
	GameState.from_pause_menu = false
	visible = false
	SignalHub.focus_continue_button.emit()
