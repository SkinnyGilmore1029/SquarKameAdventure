class_name PointsGlobals
extends Node


var current_score: int = 0
var high_score: int = 0

var life_points: int = 0
var points_to_gain_life: int = 800

func _ready() -> void:
	SignalHub.life_points_collected.connect(add_life_points)


func _process(delta: float) -> void:
	calculate_high_score()
	points_life()

func _remaining_life_points(points: int) -> int:
	var remaining_points: int = points - points_to_gain_life
	if remaining_points < 0:
		return 0
	return remaining_points

func points_life() -> void:
	if life_points >= points_to_gain_life:
		SignalHub.one_up_global.emit()
		SignalHub.one_up_collected.emit(PlayerGlobals.players_lives)
		AudioBus.play_sound("OneUps")
		life_points = _remaining_life_points(life_points)



func calculate_high_score() -> void:
	if current_score > high_score:
		high_score = current_score

func add_life_points(points: int) -> void:
	life_points += points