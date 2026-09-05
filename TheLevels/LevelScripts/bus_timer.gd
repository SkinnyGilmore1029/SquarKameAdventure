extends Timer

@export var bad_guys_node: Node2D
@export var level_node: Node2D

var spawn_vehicle: String = "Bus"

func _on_timeout() -> void:
	EnemySpawner.new_spawn(spawn_vehicle, level_node.level_data, bad_guys_node)
	wait_time = randi_range(5, 9)
	start()
