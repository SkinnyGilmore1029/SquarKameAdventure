class_name LevelDataManager
extends Resource

@export var send_to_level: int
@export var spawn_in_level_at: Vector2


var enemy_types: Array[String]
var spawn_positions: Dictionary[String, Array]
var speed_choices: Dictionary[String, Array]

#Made them arrays so levels can have varying numbers of each.
var teleporter_positions: Array[Vector2]
var lock_positions: Array[Vector2]
var key_positions: Array[Vector2]
var oneup_positions: Array[Vector2]
var hint_positions: Array[Vector2]

