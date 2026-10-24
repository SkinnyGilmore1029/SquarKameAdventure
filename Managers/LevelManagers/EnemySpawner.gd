class_name EnemyManager
extends Node

#Need to save to use in Timers
var level_enemies_strings: Array[String]

# Vehicles must be separated horizontally when they enter the same lane.
const SPAWN_LANE_Y_TOLERANCE: float = 60.0
const SPAWN_MIN_X_GAP: float = 300.0

#Loads with ready function
var enemy_scenes: Dictionary[String, String] = {
	"Car" : "res://Obstacles/BadGuys/Car.tscn",
	"Car2" : "res://Obstacles/BadGuys/Car2.tscn",
	"Truck" : "res://Obstacles/BadGuys/Truck.tscn",
	"Bus" : "res://Obstacles/BadGuys/Bus.tscn",
	"Tornado" : "res://Obstacles/BadGuys/Tornado.tscn",
	"Bolder" : "res://Obstacles/BadGuys/Bolder.tscn"

}


#-----------------Need this to start then will spawn one by one---------------

##Sets the enemy types for the level by storing them in the level_enemies_strings array. This function is called from the level script to specify which enemies should be spawned in the level.
func which_enemy_types(enemy_list: Array[String]) -> void:
	level_enemies_strings = enemy_list

##Creates an array of PackedScenes for the specified enemy types in the level_enemies_strings array.
func make_node_types() -> Array[PackedScene]:
	if !level_enemies_strings:
		push_warning("No enemy types specified for this level.")
		return []
	var enemy_scenes_nodes: Array[PackedScene] = []
	for enemy_type in level_enemies_strings:
		var enemy_scene = load(enemy_scenes.get(enemy_type))
		enemy_scenes_nodes.append(enemy_scene)
	return enemy_scenes_nodes


##Gets a random spawn location for the specified enemy type from the provided spawn_dict. If there are no spawn locations defined for the enemy type, it returns Vector2.ZERO and logs a warning.
func get_random_spawn(enemy_type: String, spawn_dict: Dictionary) ->Vector2:
	if !spawn_dict.has(enemy_type):
		push_warning("No spawn locations defined for enemy type: %s" % enemy_type)
		return Vector2.ZERO
	if len(spawn_dict[enemy_type]) == 0:
		push_warning("No spawn locations available for enemy type: %s" % enemy_type)
		return Vector2.ZERO
	if len(spawn_dict[enemy_type]) == 1:
		return spawn_dict[enemy_type][0] #already a single vector

	var chosen_spawn = spawn_dict[enemy_type][randi() % len(spawn_dict[enemy_type])]
	return chosen_spawn

func get_clear_spawn(enemy_type: String, choices: Array, bad_guys: Node) -> Vector2:
	if choices.is_empty():
		push_warning("No spawn locations available for enemy type: %s" % enemy_type)
		return Vector2.ZERO

	var shuffled_choices: Array = choices.duplicate()
	shuffled_choices.shuffle()
	for spawn_position in shuffled_choices:
		var spawn_is_clear := true
		for existing_vehicle in bad_guys.get_children():
			if not existing_vehicle is RespawningEnemyLogic:
				continue
			var same_lane := absf(existing_vehicle.global_position.y - spawn_position.y) < SPAWN_LANE_Y_TOLERANCE
			var too_close := absf(existing_vehicle.global_position.x - spawn_position.x) < SPAWN_MIN_X_GAP
			if same_lane and too_close:
				spawn_is_clear = false
				break
		if spawn_is_clear:
			return spawn_position

	# All configured locations are temporarily occupied. Timers can retry later.
	return Vector2.ZERO

func get_random_speed(enemy_type: String, speed_dict: Dictionary) -> int:
	if !speed_dict.has(enemy_type):
		push_warning("No speed choices defined for enemy type: %s" % enemy_type)
		return 0
	if len(speed_dict[enemy_type]) == 0:
		push_warning("No speed choices available for enemy type: %s" % enemy_type)
		return 0
	if len(speed_dict[enemy_type]) == 1:
		return speed_dict[enemy_type][0] #already a single speed

	var chosen_speed = speed_dict[enemy_type][randi() % len(speed_dict[enemy_type])]
	return chosen_speed

func spawn_enemy(spawn_dict: Dictionary, speed_dict: Dictionary, bad_guys: Node) -> void:
	var level_enemy_scenes = make_node_types()

	if !level_enemy_scenes:
		push_warning("No enemy types available to spawn.")
		return

	# I think right here is where i would add the get_random spawn.
	for enemy_scene in level_enemy_scenes:
		var enemy_instance = enemy_scene.instantiate()
		var enemy_type_name = enemy_instance.name
		var spawn_position = get_clear_spawn(
			enemy_type_name,
			spawn_dict.get(enemy_type_name, []),
			bad_guys
		)
		var speed = get_random_speed(enemy_type_name, speed_dict)

		if spawn_position == Vector2.ZERO:
			enemy_instance.queue_free()
			continue

		enemy_instance.global_position = spawn_position
		enemy_instance.enemy_data.speed = speed

		bad_guys.add_child(enemy_instance)


#-----------------Single Spawn-------------------------------------

func get_random_spawn2(enemy_type: String, choices: Array) -> Vector2:
	if len(choices) == 0:
		push_warning("Can not use empty Array. Check %s: Type, %s choices." % [enemy_type, choices])
		return Vector2.ZERO
	if len(choices) == 1:
		return choices[0]
	var chosen_spawn = choices[randi() %len(choices)]
	return chosen_spawn

func get_random_speed2(enemy_type: String, speed_array: Array) -> int:
	if len(speed_array) == 0:
		push_warning("No speed choices available for enemy type: %s" % enemy_type)
		return 0
	if len(speed_array) == 1:
		return speed_array[0]
	var chosen_speed = speed_array[randi() % len(speed_array)]
	return chosen_speed



func new_spawn(enemy_type: String, the_level_data: LevelDataManager, bad_guy_node: Node) -> void:
	if !enemy_scenes.has(enemy_type):
		push_warning("Enemy_type %s not a scene." % enemy_type)
		return
	var the_enemy_node = load(enemy_scenes[enemy_type])
	var the_enemy_instance = the_enemy_node.instantiate()
	var spawn_position = get_clear_spawn(
		the_enemy_instance.name,
		the_level_data.spawn_positions.get(enemy_type, []),
		bad_guy_node
		)
	#print("Car spawn result: ", spawn_position, " children: ", bad_guy_node.get_children())

	if spawn_position == Vector2.ZERO:
		the_enemy_instance.queue_free()
		return

	var speed = get_random_speed2(
	enemy_type,
	the_level_data.speed_choices[enemy_type]
	)


	the_enemy_instance.global_position = spawn_position
	the_enemy_instance.enemy_data.speed = speed

	bad_guy_node.add_child(the_enemy_instance)
