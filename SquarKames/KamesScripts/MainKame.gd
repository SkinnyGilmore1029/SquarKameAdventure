class_name MainKame
extends CharacterBody2D


@export var player_data: PlayerGlobalsManager


func _ready() -> void:
	self.global_position = player_data.new_game_spawn_position
