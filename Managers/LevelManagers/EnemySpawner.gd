class_name EnemyManager
extends Node

#Need to save to use in Timers
var level_enemies_strings: Array[String]


##Sets the enemy types for the level by storing them in the level_enemies_strings array. This function is called from the level script to specify which enemies should be spawned in the level.
func which_enemy_types(enemy_list: Array[String]) -> void:
	level_enemies_strings = enemy_list

##Creates an array of PackedScenes for the specified enemy types in the level_enemies_strings array.
func make_node_types() -> Array[PackedScene]:
	if !level_enemies_strings:
		push_warning("No enemy types specified for this level.")
		return []
	var enemy_scenes: Array[PackedScene] = []
	for enemy_type in level_enemies_strings:
		var enemy_scene = load("res://Obstacles/BadGuys/%s.tscn" % enemy_type)
		enemy_scenes.append(enemy_scene)
	return enemy_scenes


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

	for enemy_scene in level_enemy_scenes:
		var enemy_instance = enemy_scene.instantiate()
		var enemy_type_name = enemy_instance.name
		var spawn_position = get_random_spawn(enemy_type_name, spawn_dict)
		var speed = get_random_speed(enemy_type_name, speed_dict)

		if spawn_position == Vector2.ZERO:
			push_warning("Failed to spawn enemy of type: %s due to invalid spawn position." % enemy_type_name)
			enemy_instance.queue_free()
			continue

		enemy_instance.global_position = spawn_position
		enemy_instance.enemy_data.speed = speed

		bad_guys.add_child(enemy_instance)
