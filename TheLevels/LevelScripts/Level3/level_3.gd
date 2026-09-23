class_name Level3Manager
extends Node2D

@export var level_data: LevelDataManager
@onready var bad_guys_node = $Level3_BadGuys/Respawning
@onready var hint_frog_text := $Helpful/HintFrog/HintPanel/Label


func _ready() -> void:
    set_level_data()

    EnemySpawner.which_enemy_types(level_data.enemy_types)
    EnemySpawner.spawn_enemy(level_data.spawn_positions, level_data.speed_choices, bad_guys_node)

func set_level_data() -> void:
    hint_frog_text.text = "This level is under construction"
    level_data.enemy_types= ["Car", "Truck"]
    level_data.spawn_positions = {
        "Car" : [Vector2(-135,-275)],
        "Truck" : [Vector2(2140,72)]
    }
    level_data.speed_choices = {
        "Car" : [250, 300, 350],
        "Truck" : [200, 230, 250]
    }