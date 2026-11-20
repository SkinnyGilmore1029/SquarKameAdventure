class_name GameStateManager
extends Node

var last_title_selection: String
var current_level: int = 1
var continuing_from_game_over: bool = false
var picking_level: bool = false
var from_pause_menu: bool = false
var level_going_to: int
var level_selected: int
var hot_level:bool = false
var selected_kame: String
var difficulty_selected: String
var title_screen: StringName = "res://UI_Screens/Screens/TitleScreen.tscn"
var level_select: StringName = "res://UI_Screens/Screens/LevelSelect.tscn"
var difficulty_screen: StringName = "res://UI_Screens/Screens/DifficultySetting.tscn"
var character_select: StringName = "res://UI_Screens/Screens/KameSelect.tscn"
var main_scene: StringName = "res://MainGame.tscn"
var option_screen: StringName = "res://UI_Screens/Screens/OptionsScreen.tscn"
var control_screen: StringName = "res://UI_Screens/Screens/ControlScreen.tscn"

var level_names: Dictionary[int, String] = {
    1 : "Apple Road",
    2 : "Crocodile Creek",
    3 : "Speed Runners Nightmare",
    4 : "Dessert Chaos",
    5 : "Oasis Run"
}

var attached_pins: Array[RigidBody2D] = []


func _ready() -> void:
    connect_all_signals()


func connect_all_signals() -> void:
    SignalHub.add_pinned_body.connect(add_body)
    SignalHub.remove_pinned_body.connect(remove_body)
    SignalHub.load_array.connect(transfer_array)
    SignalHub.look_array.connect(look_inside)

func add_body(pin_body: RigidBody2D) -> void:
    if pin_body not in attached_pins:
        attached_pins.append(pin_body)

func remove_body(pin_body: RigidBody2D) -> void:
    if pin_body in attached_pins:
        attached_pins.erase(pin_body)

func transfer_array(to_array: Array[RigidBody2D]) -> void:
    for pin in attached_pins:
        if pin not in to_array:
            to_array.append(pin)

func look_inside() -> void:
    print(attached_pins, "<--attached_pins")