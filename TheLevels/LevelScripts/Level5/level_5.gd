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
@onready var bush1: StaticBody2D = $MagicBushes/MagicBush
@onready var bush2: StaticBody2D = $MagicBushes/MagicBush2



var area1_buttons: Array[Node2D]
var area2_buttons: Array[Node2D]

func _ready() -> void:
	_set_level()
	EnemySpawner.which_enemy_types((level_data.enemy_types))
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)
	EnemySpawner.new_spawn("Bolder", level_data, bad_guy_node)
	SignalHub.button_pushed_level5.connect(_add_button_count)


func _set_level() -> void:
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

func _add_button_count(button_node: Node2D, parent_node: Node2D) -> void:
	var parent_name: StringName = parent_node.name

	match parent_name:
		"Area1":
			area1_buttons.append(button_node)
			if _area_done(parent_name):
				bush1.bush_done()
				return
		"Area2":
			area2_buttons.append(button_node)
			if _area_done(parent_name):
				bush2.bush_done()
				return
		_:
			return

func _area_done(parent_name: String) -> bool:
	match parent_name:
		"Area1":
			return area1_buttons.size() == 5
		"Area2":
			return area2_buttons.size() == 6
		_:
			return false

func cool_zone(body: Node2D) -> void:
	if body is MainKame:
		SignalHub.entered_puddle.emit()

func hot_zone(body: Node2D) -> void:
	if body is MainKame:
		SignalHub.exited_puddle.emit()
