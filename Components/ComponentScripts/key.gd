class_name Keys
extends Node2D


func _ready() -> void:
    SignalHub.key_collected.connect(add_key)


func add_key() -> void:
    PlayerGlobals.key_count += 1

