class_name Locks
extends Node2D

func _ready() -> void:
    SignalHub.key_used.connect(take_key)
    SignalHub.check_point.connect(check_point_reached)

func take_key() -> void:
    PlayerGlobals.key_count = 0

func check_point_reached(parent_pos: Vector2) -> void:
    PlayerGlobals.spawn_position = parent_pos