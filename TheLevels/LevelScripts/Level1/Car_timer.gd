extends Timer

@export var bad_guys_node: Node2D
@export var level_node: Node2D


var spawn_choices: Array[String] = ["Car", "Car2"]



func _on_timeout() -> void:
	var spawn_vehicle: String = spawn_choices.pick_random()
	EnemySpawner.new_spawn(spawn_vehicle, level_node.level_data, bad_guys_node)
	EnemySpawner.new_spawn(spawn_vehicle, level_node.level_data, bad_guys_node)
	wait_time = randi() % 2 + 1
	start()
