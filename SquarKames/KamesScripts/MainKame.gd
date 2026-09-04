class_name MainKame
extends CharacterBody2D

var player_direction: String
var moving_direction: Vector2
var speed: float = 200.0

func _ready() -> void:
	self.global_position = PlayerGlobals.new_game_spawn_position
