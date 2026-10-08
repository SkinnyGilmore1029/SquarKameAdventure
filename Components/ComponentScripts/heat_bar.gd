extends Control

@onready var style = %HeatsProgressBar.get_theme_stylebox("fill")

var heat_tween: Tween
var puddle_tween_time: float

#Just a Default may change later with code.
var heat_max_value: float = 100.0
var heat_tween_time: float = 25.0
var base_unit: float = 3.0

func _ready() -> void:
	_hide_parent()
	_connect_puddle_signals()

func _connect_puddle_signals() -> void:
	SignalHub.start_hot_bar.connect(tween_heat_bar)
	SignalHub.stop_hot_bar.connect(kill_tween_bar)
	SignalHub.entered_puddle.connect(enter_puddle)
	SignalHub.exited_puddle.connect(exit_puddle)

func _process(_delta: float) -> void:
	_heat_bar_color()
	_kill_player()

func tween_heat_bar(new_value: float) -> void:
	_make_parent_visible()

	#make sure the tween is fresh
	kill_tween_bar()
	%HeatsProgressBar.max_value = new_value
	heat_tween = create_tween()
	heat_tween.tween_property(%HeatsProgressBar, "value", %HeatsProgressBar.max_value, heat_tween_time)

func _set_heat_bar() -> void:
	%HeatsProgressBar.value = 0.0
	tween_heat_bar(heat_max_value)

func _kill_player() -> void:
	if %HeatsProgressBar.value == %HeatsProgressBar.max_value:
		SignalHub.player_died.emit()
		_set_heat_bar()

func _get_heat_percent() -> float:
	#just to prevent division error
	if %HeatsProgressBar.value == 0:
		return 1.0
	var heat_percent = float(%HeatsProgressBar.value) / float(%HeatsProgressBar.max_value) * 100.0
	return heat_percent

##Handles the color of the progress bar
func _heat_bar_color()-> void:
	var heat_percent = _get_heat_percent()

	#Ugly but works.
	if heat_percent <= 25:
		style.bg_color = Color.GREEN
		%TempLabel.text = "Normal"
	elif heat_percent <= 50:
		style.bg_color = Color.YELLOW
		%TempLabel.text = "Warm"
	elif heat_percent <= 75:
		style.bg_color = Color.ORANGE
		%TempLabel.text = "Hot"
	elif heat_percent <= 90:
		style.bg_color = Color.RED
		%TempLabel.text = "Extremely Hot"
	else:
		style.bg_color = Color.DARK_RED
		%TempLabel.text = "Heat Exhaustion"

##Handles tween times for the enter_puddle function
func _adjust_tween_time() -> float:
	var heat_percent = _get_heat_percent()

	#Ugly but works.
	if heat_percent <= 25:
		return base_unit
	elif heat_percent <= 50:
		return base_unit * 2.0
	elif heat_percent <= 75:
		return base_unit * 3.0
	elif heat_percent <= 90:
		return base_unit * 4.0
	else:
		return base_unit * 5.0

func _make_parent_visible() -> void:
	get_parent().visible = true

func _hide_parent() -> void:
	get_parent().visible = false

func kill_tween_bar() -> void:
	if heat_tween == null:
		return
	heat_tween.kill()

func enter_puddle() -> void:
	kill_tween_bar()
	puddle_tween_time = _adjust_tween_time()
	heat_tween = create_tween()
	heat_tween.tween_property(%HeatsProgressBar, "value", 0, puddle_tween_time)

func exit_puddle() -> void:
	kill_tween_bar()
	heat_tween = create_tween()
	heat_tween.tween_property(%HeatsProgressBar, "value", %HeatsProgressBar.max_value, heat_tween_time)