extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fly_node: Node2D = %TheFliesGroup


@export var fly_data: FlyResource

func _on_spawn_fly_area_body_entered(body: Node2D) -> void:
	if body is MainKame:
		animated_sprite.stop()
		spawn_fly()
		%SpawnFlyArea.set_deferred("monitoring", false)

func spawn_fly() -> void:
	var fly_scene: PackedScene = load("res://HelpfulStuff/Scenes/CactusFly.tscn")
	var fly_instance: Node = fly_scene.instantiate()
	set_up_fly(fly_instance)
	fly_node.call_deferred("add_child",fly_instance)

#More will be added here
func set_up_fly(fly: Node) -> void:
	fly.global_position = fly_data.create_spawn_vector(global_position.x,global_position.y)
