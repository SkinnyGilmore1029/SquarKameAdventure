extends Timer


@export var bad_guys_node: Node2D
@export var level_node: Node2D

var spawn_choices: Array[String] = ["Truck", "DoubleBus"]

func _on_timeout() -> void:
	var spawn_vehicle: String = spawn_choices.pick_random()
	EnemySpawner.new_spawn(spawn_vehicle, level_node.level_data, bad_guys_node)
	wait_time = randi_range(2,4)
	start()
