
extends Node2D

@export var level_data: LevelDataManager

@onready var hint_frog := $Hints/HintFrog/HintPanel/Label
@onready var hint_frog2 := $Hints/HintFrog2/HintPanel/Label
@onready var key1 := $Keys/Key
@onready var key2 := $Keys/Key2
@onready var bad_guy_node = get_node("Level4_BadGuys/Respawning")

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
	set_level()
	_hide_keys()
	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)
	SignalHub.collected_fly.connect(append_fly)


func _process(_delta: float) -> void:
	_key1_access()
	_key2_access()

func set_level()->void:
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
	key1.get_node("Collectable/CollisionShape2D").set_deferred("disabled", true)
	key2.hide()
	key2.get_node("Collectable/CollisionShape2D").set_deferred("disabled" , true)

func _on_spawn_tornado_timeout() -> void:
	EnemySpawner.new_spawn("Tornado", level_data, bad_guy_node)

func append_fly(fly_name: String) -> void:
	if len(fly_group1) >= 5:
		fly_group2.append(fly_name)
		return
	fly_group1.append(fly_name)

#emits signal to lizard guarding first key if group 1 is full.
func _key1_access() -> void:
	if !emitted_one && len(fly_group1) == 5:
		key1.show()
		key1.get_node("Collectable/CollisionShape2D").set_deferred("disabled", false)
		print("key1 should be collectable now!")
		emitted_one = true

func _key2_access() -> void:
	if !emitted_two && len(fly_group2) == 5:
		key2.show()
		key2.get_node("Collectable/CollisionShape2D").set_deferred("disabled", false)
		print("key2 should be collectable now!")
		emitted_two = true
