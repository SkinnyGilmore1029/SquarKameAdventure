class_name GameStateManager
extends Node

var last_title_selection: String
var current_level: int = 1
var continuing_from_game_over: bool = false
var picking_level: bool = false
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

var level_names: Dictionary[int, String] = {
    1 : "Apple Road",
    2 : "Crocodile Creek",
    3 : "Speed Runners Nightmare"
}

