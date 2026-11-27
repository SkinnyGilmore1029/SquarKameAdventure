extends Timer

@export var bad_guy_node: Node2D
@export var level_node: Node2D



func _on_timeout() -> void:
	EnemySpawner.new_spawn("BigBeetle", level_node.level_data, bad_guy_node)
	wait_time = randi_range(3, 5)
	start()
