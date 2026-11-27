class_name PlayerGlobalsManager
extends Node

var players_lives: int = 10
#var players_current_level: int = 1
var new_game_spawn_position: Vector2 = Vector2(560, 768)

var player_direction: String = "up"
var moving_direction: Vector2
var tail_direction: Vector2
var default_speed: float = 230.0
var speed: float = 230.0
var spawn_position: Vector2
var death_position: Vector2

var key_count: int = 0

var kame_selection: Dictionary[String, String] = {
	"Orange" : "uid://c4plgj0bg1e6q",
	"Green" : "uid://c0oq4upgy56xp",
	"Purple" : "uid://cf1tnatxhjaia"
}

var tail_positions: Dictionary[String, Vector2] = {
	"up" : Vector2(0, 15),
	"down" : Vector2(0, -15),
	"left" : Vector2(15, 0),
	"right" : Vector2(-15, 0),
}