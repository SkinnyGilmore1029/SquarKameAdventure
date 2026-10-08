extends Node2D

@export var level_data: LevelDataManager
@onready var bad_guys_node = $Level3_BadGuys/Respawning
@onready var hint_frog_text := $Helpful/Hints/HintFrog/HintPanel/Label
@onready var hint_frog2_text := $Helpful/Hints/HintFrog2/HintPanel/Label
@onready var hint_frog3_text := $Helpful/Hints/HintFrog3/HintPanel/Label
@onready var key_3 := $Keys/Key3

var strawberries_offered: int = 0

func _ready() -> void:
	set_level_data()
	SignalHub.giving_offer.connect(take_offering)
	EnemySpawner.which_enemy_types(level_data.enemy_types)
	EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)

func set_level_data() -> void:
	hint_frog_text.text = "The beetles are guarding a key."
	hint_frog2_text.text = "You have to be brave.\nGo against the traffic.\nThere is a key at the\n end of the road."
	hint_frog3_text.text = "Try pushing stuff around.\nIt may lead to a key!"
	level_data.enemy_types= ["Car", "Truck"]
	level_data.spawn_positions = {
		"Car" : [Vector2(-135,-275)],
		"Truck" : [Vector2(2140,72)]
	}
	level_data.speed_choices = {
		"Car" : [250, 300, 350],
		"Truck" : [200, 230, 250]
	}
	key_3.visible = false
	key_3.get_node("Collectable/CollisionShape2D").set_deferred("disabled", true)

func take_offering() -> void:
	strawberries_offered += 1
	if strawberries_offered == 3:
		key_3.visible = true
		key_3.get_node("Collectable/CollisionShape2D").set_deferred("disabled", false)

