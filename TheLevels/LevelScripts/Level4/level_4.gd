
extends Node2D

@export var level_data: LevelDataManager

@onready var hint_frog: Label = $Hints/HintFrog/HintPanel/Label
@onready var hint_frog2: Label = $Hints/HintFrog2/HintPanel/Label
@onready var lizard_label: Label = $Lizards/Lizard/FlyCountContainer/FlyCountLabel
@onready var lizard2_label: Label = $Lizards/Lizard2/FlyCountContainer/FlyCountLabel
@onready var lizard: CharacterBody2D = $Lizards/Lizard
@onready var lizard2: CharacterBody2D = $Lizards/Lizard2
@onready var key1: Node2D = $Keys/Key
@onready var key2: Node2D = $Keys/Key2
@onready var key1_collision: CollisionShape2D = $Keys/Key/Collectable/CollisionShape2D
@onready var key2_collision: CollisionShape2D = $Keys/Key2/Collectable/CollisionShape2D
@onready var bad_guy_node: Node2D = $Level4_BadGuys/Respawning

@onready var tornado_spawn_array: Array[Vector2] = [
	%TornadoSpawn1.position,
	%TornadoSpawn2.position,
	%TornadoSpawn3.position,
	%TornadoSpawn4.position,
	%TornadoSpawn5.position,
	%TornadoSpawn6.position
	]

var fly_group1: Array[String] = []
var fly_group2: Array[String] = []
var emitted_one: bool
var emitted_two: bool

func _ready() -> void:
	_set_level()
	_hide_keys()
	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)
	SignalHub.collected_fly.connect(append_fly)


func _set_level() -> void:
	emitted_one = false
	emitted_two = false
	#level_data.heat_timer = 100.0
	hint_frog.text = "The Lizard holds the key.\nBeware of the Scorpions!\n"
	hint_frog2.text = "Its is very hot here.\nFind \bPuddles\b to cool down!\n"
	level_data.enemy_types = ["Tornado"]
	level_data.spawn_positions = {
		"Tornado" : tornado_spawn_array
	}
	level_data.speed_choices = {
		"Tornado" : [250, 300, 350]
	}
	SignalHub.start_hot_bar.emit(100.0)


func _hide_keys() -> void:
	key1.hide()
	key1_collision.set_deferred("disabled", true)
	key2.hide()
	key2_collision.set_deferred("disabled" , true)

func _on_spawn_tornado_timeout() -> void:
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)

func handle_fly_count(fly_group: Array[String]) -> String:
	var count_string: String = "Flies %d/5" % len(fly_group)
	return count_string


func append_fly(fly_name: String) -> void:
	if len(fly_group1) >= 5:
		fly_group2.append(fly_name)
		lizard2_label.text = handle_fly_count(fly_group2)
		_key2_access()
		return
	fly_group1.append(fly_name)
	lizard_label.text = handle_fly_count(fly_group1)
	_key1_access()


func _key1_access() -> void:
	if !emitted_one && len(fly_group1) == 5:
		key1.show()
		key1_collision.set_deferred("disabled", false)
		emitted_one = true
		lizard.has_all_flies = true
		lizard_label.text = "Thank you for the flies."

func _key2_access() -> void:
	if !emitted_two && len(fly_group2) == 5:
		key2.show()
		key2_collision.set_deferred("disabled", false)
		emitted_two = true
		lizard2.has_all_flies = true
		lizard2_label.text = "Thank you for the flies."
