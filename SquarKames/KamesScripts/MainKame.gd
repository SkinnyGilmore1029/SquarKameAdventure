class_name MainKame
extends CharacterBody2D


var player_data := PlayerGlobals


func _ready() -> void:
	self.global_position = player_data.new_game_spawn_position
