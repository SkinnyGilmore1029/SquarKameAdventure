class_name MainKame
extends CharacterBody2D

@onready var player_camera: Camera2D = $Camera2D
var current_camera_set: String = "Level1"


var player_data := PlayerGlobals
var camera_limits: Dictionary = {
	"Level1" : {
		"Top" : -855,
		"Bottom" : 800,
		"Left" : 0,
		"Right" : 1200
	},
	"Level2" : {
		"Top" : -55,
		"Bottom" : 815,
		"Left" : 0,
		"Right" : 2400
	},
	"Level3" : {
		"Top" : -786,
		"Bottom" : 1609,
		"Left" : 0,
		"Right" : 2020
	}
}


func _ready() -> void:
	SignalHub.player_died.connect(died)
	SignalHub.changed_levels.connect(new_level_pos)
	SignalHub.key_collected.connect(add_key)
	SignalHub.key_used.connect(take_key)
	SignalHub.one_up_global.connect(add_oneup)
	set_camera_position()
	set_player_data()


func died() -> void:
	$StateMachine.transition_to("Death")

func add_key() -> void:
	player_data.key_count += 1

func take_key() -> void:
	player_data.key_count -=1
	if player_data.key_count < 0:
		player_data.key_count = 0

func add_oneup() -> void:
	player_data.players_lives +=1


func new_level_pos(level_name: String) -> void:
	self.global_position = player_data.spawn_position
	if level_name not in camera_limits:
		push_warning("Forgot to add %s to camera_limits in MainKame.gd" % level_name)
		return
	player_camera.limit_right = camera_limits[level_name]["Right"]
	player_camera.limit_bottom = camera_limits[level_name]["Bottom"]
	player_camera.limit_top = camera_limits[level_name]["Top"]
	player_camera.limit_left = camera_limits[level_name]["Left"]

func set_player_data() -> void:
	self.global_position = player_data.new_game_spawn_position
	player_data.spawn_position = player_data.new_game_spawn_position

func set_camera_position() -> void:
	player_data.spawn_position = player_data.new_game_spawn_position
	player_camera.limit_right = camera_limits[current_camera_set]["Right"]
	player_camera.limit_bottom = camera_limits[current_camera_set]["Bottom"]
	player_camera.limit_top = camera_limits[current_camera_set]["Top"]
	player_camera.limit_left = camera_limits[current_camera_set]["Left"]