class_name OneUps
extends Node2D

func _ready() -> void:
    SignalHub.one_up_global.connect(add_oneup)


func add_oneup() -> void:
    PlayerGlobals.players_lives += 1