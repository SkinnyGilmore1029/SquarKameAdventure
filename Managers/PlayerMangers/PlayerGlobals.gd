class_name PlayerGlobalsManager
extends Resource

@export var players_lives: int = 10
@export var players_current_level: int = 1
@export var new_game_spawn_position: Vector2 = Vector2(560, 768)

var player_direction: String
var moving_direction: Vector2
var speed: float = 200.0