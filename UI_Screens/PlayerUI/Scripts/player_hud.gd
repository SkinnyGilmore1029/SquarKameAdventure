class_name PlayerHud
extends Control



func _ready() -> void:
	connect_signals()
	add_one_up(PlayerGlobals.players_lives)

func connect_signals() -> void:
	SignalHub.one_up_collected.connect(add_one_up)
	SignalHub.subtract_one_up.connect(take_one_up)
	SignalHub.change_level_number.connect(change_levelnumber)
	SignalHub.change_key_count.connect(change_keycount)
	SignalHub.points_collected.connect(add_to_points)

func add_one_up(new_count: int) -> void:
	%LifeCount.text = str(new_count)

func take_one_up(new_count: int) -> void:
	%LifeCount.text = str(new_count)

func change_levelnumber(new_level: int) -> void:
	%LevelNumberLabel.text = str(new_level)

func change_keycount(new_count: int) -> void:
	%KeyCountLabel.text = str(new_count)

func add_to_points(value: int) -> void:
	var current_total = int(%PointsNumberLabel.text)
	var new_total = current_total + value
	PlayerGlobals.current_score = new_total
	%PointsNumberLabel.text = str(new_total)