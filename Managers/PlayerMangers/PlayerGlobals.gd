class_name PlayerGlobalsManager
extends Node

var players_lives: int = 10
var players_current_level: int = 1
var new_game_spawn_position: Vector2 = Vector2(560, 768)

var player_direction: String = "up"
var moving_direction: Vector2
var default_speed: float = 230.0
var speed: float = 230.0
var spawn_position: Vector2

var key_count: int = 0
var current_score: int = 0

var kame_selection: Dictionary[String, String] = {
	"Orange" : "res://SquarKames/KamesScenes/OrangeKame.tscn",
	"Green" : "res://SquarKames/KamesScenes/SquarKame.tscn",
	"Purple" : "res://SquarKames/KamesScenes/PurpleKame.tscn"
}