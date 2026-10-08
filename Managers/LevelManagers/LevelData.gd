class_name LevelDataManager
extends Resource

@export var send_to_level: int

#----------------------------for respawning objects-----------------------

var enemy_types: Array[String]
var spawn_positions: Dictionary[String, Array]
var speed_choices: Dictionary[String, Array]

var heat_value: float