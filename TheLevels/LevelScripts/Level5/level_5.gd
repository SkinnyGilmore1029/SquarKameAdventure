extends Node2D


@export var level_data: LevelDataManager

@onready var bad_guy_node: Node2D = $Level5_BadGuys
@onready var bolder_spawns: Array[Vector2] = [
    %BolderSpawn1.position,
    %BolderSpawn2.position,
    %BolderSpawn3.position,
    %BolderSpawn4.position]
@onready var tornado_spawns: Array[Vector2] = [
	%TornadoSpawn1.position,
	%TornadoSpawn2.position,
	%TornadoSpawn3.position,
	%TornadoSpawn4.position,
	%TornadoSpawn5.position]
func _ready() -> void:
	set_level()
	EnemySpawner.which_enemy_types((level_data.enemy_types))
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)
	EnemySpawner.new_spawn("Bolder", level_data, bad_guy_node)


func set_level() -> void:
	SignalHub.start_hot_bar.emit(100.0)
	level_data.enemy_types = ["Tornado", "Bolder"]
	level_data.spawn_positions = {
		"Bolder" : bolder_spawns,
		"Tornado" : tornado_spawns,
	}
	level_data.speed_choices = {
		"Bolder" : [150, 175, 200],
		"Tornado" : [250, 300, 350]
	}

func _on_tornado_timer_timeout() -> void:
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)


func _on_bolder_timer_timeout() -> void:
	EnemySpawner.new_spawn("Bolder", level_data, bad_guy_node)


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
