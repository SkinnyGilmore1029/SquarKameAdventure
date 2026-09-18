class_name  Level2Manager
extends Node2D


@export var level_data: LevelDataManager
@onready var key: Node2D = $Keys/Key
@onready var key_2: Node2D = $Keys/Key2
@onready var hint_frog_text := $Helpful/HintFrog/HintPanel/Label


var button_group1: Array[Node2D]
var button_group2: Array[Node2D]

func _ready() -> void:
	set_level_up()
	SignalHub.button_pushed_level2.connect(add_to_button_count)


func set_level_up() -> void:
	hint_frog_text.text = "Those Stars are actually buttons.\n See what happens if you push\n them all!"
	key.hide()
	key.get_node("Collectable/CollisionShape2D").set_deferred("disabled", true)
	key_2.hide()
	key_2.get_node("Collectable/CollisionShape2D").set_deferred("disabled", true)

func add_to_button_count(button_node: Node2D, parent_node: Node2D) -> void:
	var parent_node_name: StringName = parent_node.name

	match parent_node_name:
		"ButtonGroup1":
			button_group1.append(button_node)
			if make_key_visible(parent_node_name):
				key.show()
				key.get_node("Collectable/CollisionShape2D").set_deferred("disabled", false)
		"ButtonGroup2":
			button_group2.append(button_node)
			if make_key_visible(parent_node_name):
				key_2.show()
				key_2.get_node("Collectable/CollisionShape2D").set_deferred("disabled", false)

func make_key_visible(parent_name: String) -> bool:
	match parent_name:
		"ButtonGroup1":
			return button_group1.size() == 5
		"ButtonGroup2":
			return button_group2.size() == 6
		_ :
			return false