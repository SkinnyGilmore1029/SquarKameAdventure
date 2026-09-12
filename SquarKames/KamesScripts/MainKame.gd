class_name MainKame
extends CharacterBody2D

@onready var player_camera: Camera2D = $Camera2D

var player_data := PlayerGlobals
var camera_limits: Dictionary = {
	"Level1" : {
		"Top" : -800,
		"Bottom" : 800,
		"Left" : 0,
		"Right" : 1200
	},
	"Level2" : {
		"Top" : 0,
		"Bottom" : 800,
		"Left" : 0,
		"Right" : 2400
	}
}


func _ready() -> void:
	SignalHub.player_died.connect(died)
	SignalHub.changed_levels.connect(new_level_pos)
	self.global_position = player_data.new_game_spawn_position
	player_data.spawn_position = player_data.new_game_spawn_position


func died() -> void:
	player_data.players_lives -= 1
	self.global_position = player_data.spawn_position

func new_level_pos(level_name: String) -> void:
	self.global_position = player_data.spawn_position
	if level_name not in camera_limits:
		push_warning("Forgot to add %s to camera_limits in MainKame.gd" % level_name)
		return
	player_camera.limit_right = camera_limits[level_name]["Right"]
	player_camera.limit_bottom = camera_limits[level_name]["Bottom"]
	player_camera.limit_top = camera_limits[level_name]["Top"]
	player_camera.limit_left = camera_limits[level_name]["Left"]
