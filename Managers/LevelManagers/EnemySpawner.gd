class_name EnemyManager
extends Node

#Need to save to use in Timers
var level_enemies_strings: Array[String]
var enemy_scenes: Dictionary[String, String]
var bad_guy_folder := DirAccess.open("res://Obstacles/BadGuys")

##gets all the children nodes paths so i don't have to always update the dictionary
func _ready() -> void:
	for file in bad_guy_folder.get_files():
		if file.ends_with(".tscn"):
			enemy_scenes[file.get_basename()] = "res://Obstacles/BadGuys/" + file



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

func get_random_spawn2(enemy_type: String, choices: Array[Vector2]) -> Vector2:
	if len(choices) == 0:
		push_warning("Can not use empty Array. Check %s: Type, %s choices." % [enemy_type, choices])
		return Vector2.ZERO
	if len(choices) == 1:
		return choices[0]
	var chosen_spawn = choices[randi() %len(choices)]
	return chosen_spawn

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

func get_random_time(enemy_type: String, time_dict: Dictionary) -> float:
	if !time_dict.has(enemy_type):
		push_warning("No time choices defined for enemy type: %s % enemy_type")
		return 3.0

	if len(time_dict[enemy_type]) == 0:
		push_warning("No times were added to %s time choices array check leveldata.gd" % enemy_type)
		return 3.0
	if len(time_dict[enemy_type]) == 1:
		return time_dict[enemy_type][0]

	var chosen_time = time_dict[enemy_type][randi() % len(time_dict[enemy_type])]
	return chosen_time


func spawn_enemy(spawn_dict: Dictionary, speed_dict: Dictionary, time_dict: Dictionary, bad_guys: Node) -> void:
	var level_enemy_scenes = make_node_types()

	if !level_enemy_scenes:
		push_warning("No enemy types available to spawn.")
		return

	for enemy_scene in level_enemy_scenes:
		var enemy_instance = enemy_scene.instantiate()
		var enemy_type_name = enemy_instance.name
		var spawn_position = get_random_spawn(enemy_type_name, spawn_dict)
		var speed = get_random_speed(enemy_type_name, speed_dict)
		var time = get_random_time(enemy_type_name, time_dict)

		if spawn_position == Vector2.ZERO:
			push_warning("Failed to spawn enemy of type: %s due to invalid spawn position." % enemy_type_name)
			enemy_instance.queue_free()
			continue

		enemy_instance.global_position = spawn_position
		enemy_instance.enemy_data.speed = speed
		enemy_instance.enemy_data.spawn_time = time

		bad_guys.add_child(enemy_instance)

func new_spawn(enemy_type: String, the_level_data: LevelDataManager) -> void:
	if !enemy_scenes.has(enemy_type):
		push_warning("Enemy_type %s not a scene." % enemy_type)
		return
	var the_enemy_node = load(enemy_scenes[enemy_type])
	var the_enemy_instance = the_enemy_node.instantiate()
	var spawn_position = get_random_spawn2(
		the_enemy_instance.name,
		the_level_data.spawn_positions[enemy_type])

	the_enemy_instance.global_position = spawn_position