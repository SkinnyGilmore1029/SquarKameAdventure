class_name PlayerHud
extends Control



func _ready() -> void:
	SignalHub.one_up_collected.connect(add_one_up)
	SignalHub.subtract_one_up.connect(take_one_up)
	SignalHub.change_level_number.connect(change_number)


func add_one_up(new_count: int) -> void:
	%LifeCount.text = str(new_count)

func take_one_up(new_count: int) -> void:
	%LifeCount.text = str(new_count)

func change_number(new_level: int) -> void:
	%LevelNumberLabel.text = str(new_level)
