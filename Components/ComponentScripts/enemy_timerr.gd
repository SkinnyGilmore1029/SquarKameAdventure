class_name EnemyTimer
extends Timer

@export var bad_guys_node: Node2D
@export var level_node: Node2D

func _on_timeout() -> void:
	EnemySpawner.which_enemy_types(level_node.level_data.enemy_types)
	EnemySpawner.spawn_enemy(
	level_node.level_data.spawn_positions,
	level_node.level_data.speed_choices,
	level_node.level_data.time_choices,
	bad_guys_node)
	#wait_time = i need what time is chosen when the enemy spawns hmm dont know how i can or if i can 
	start()
