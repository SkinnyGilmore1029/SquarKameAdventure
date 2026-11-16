extends CanvasLayer

#Main Pause menu

func _ready() -> void:
    visible = false
    connect_my_signals()

func connect_my_signals() -> void:
    SignalHub.show_pause_menu.connect(open_pause_menu)
    SignalHub.hide_pause_menu.connect(close_pause_menu)

func open_pause_menu() -> void:
    GameState.from_pause_menu = true
    visible = true

func close_pause_menu() -> void:
    GameState.from_pause_menu = false
    visible = false