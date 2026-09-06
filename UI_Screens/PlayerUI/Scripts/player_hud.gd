class_name PlayerHud
extends Control



func _ready() -> void:
    SignalHub.one_up_collected.connect(Change_one_up)


func Change_one_up(new_count: int) -> void:
    %LifeCountLabel.text = str(new_count)