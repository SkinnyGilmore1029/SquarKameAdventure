class_name MainKame
extends CharacterBody2D


var player_data := PlayerGlobals



func _ready() -> void:
	SignalHub.player_died.connect(died)
	self.global_position = player_data.new_game_spawn_position
	player_data.spawn_position = player_data.new_game_spawn_position


func died() -> void:
	player_data.players_lives -= 1
	self.global_position = player_data.spawn_position