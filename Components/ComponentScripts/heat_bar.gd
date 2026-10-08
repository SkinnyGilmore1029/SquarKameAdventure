extends Control

@onready var style = %HeatsProgressBar.get_theme_stylebox("fill")


var heat_tween: Tween

func _ready() -> void:
	_hide_parent()
	SignalHub.start_hot_bar.connect(_tween_heat_bar)
	SignalHub.stop_hot_bar.connect(stop_tween_bar)


func _process(_delta: float) -> void:
	_heat_bar_color()
	_kill_player()

func _tween_heat_bar(new_value: float) -> void:
	_make_parent_visible()

	#make sure the tween is fresh
	if heat_tween != null:
		heat_tween.kill()

	heat_tween = create_tween()
	heat_tween.tween_property(%HeatsProgressBar, "value", new_value, 35.00)

func _kill_player() -> void:
	if %HeatsProgressBar.value == %HeatsProgressBar.max_value:
		SignalHub.player_died.emit()
		_set_heat_bar()

##Handles the color of the progress bar
func _heat_bar_color()-> void:
	#just to prevent division error
	if %HeatsProgressBar.value == 0:
		return
	var heat_percent = float(%HeatsProgressBar.value) / float(%HeatsProgressBar.max_value) * 100.0

	#Ugly but works.
	if heat_percent <= 25:
		style.bg_color = Color.GREEN
	elif heat_percent <= 50:
		style.bg_color = Color.YELLOW
	elif heat_percent <= 75:
		style.bg_color = Color.ORANGE
	elif heat_percent <= 90:
		style.bg_color = Color.RED
	else:
		style.bg_color = Color.DARK_RED


func _set_heat_bar() -> void:
	%HeatsProgressBar.value = 0.0
	_tween_heat_bar(%HeatsProgressBar.max_value)

func _make_parent_visible() -> void:
	get_parent().visible = true

func _hide_parent() -> void:
	get_parent().visible = false

func stop_tween_bar() -> void:
	if heat_tween == null:
		return
	heat_tween.kill()