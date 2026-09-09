class_name Locks
extends Node2D

func _ready() -> void:
    SignalHub.key_used.connect(take_key)

func take_key() -> void:
    PlayerGlobals.key_count = 0