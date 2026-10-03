class_name LevelChangeManager
extends Node


var level_scenes: Dictionary[int,Array] = {
	1 : ["res://TheLevels/LevelScenes/Level1.tscn", Vector2(560, 768)],
	2 : [ "res://TheLevels/LevelScenes/Level2.tscn", Vector2(92, 715)],
	3 : ["res://TheLevels/LevelScenes/Level3.tscn", Vector2(126,-589)]
}


func change_level(new_level: int) -> void:
	#check the dictionary first.
	#don't waste time making variables if invalid entry.
	if new_level not in level_scenes:
		push_warning("Level %d not in level_scenes dictionary in LevelChangeManger.gd." % new_level)
		return

	var screen_transitions: ScreenTransitions = get_node(
	"/root/MainGame/ScreenTranstion"
)
	#Make the screen black before we change the level.
	#gets stuck here?
	await screen_transitions.fade_in(new_level)

	#pause here
	#Get the Level Parent Node
	var levels_node = get_node("/root/MainGame/Levels")
	#Delete current level node
	if levels_node.get_child_count() > 0:
		levels_node.get_child(0).queue_free()

	#Instantiate the New Level.
	var next_level: PackedScene = load(level_scenes[new_level][0])
	var next_level_instance = next_level.instantiate()

	#Put the new level in the Levels Node in MainGame.
	levels_node.add_child(next_level_instance)

	#change the players spawn postion
	PlayerGlobals.spawn_position = level_scenes[new_level][1]
	SignalHub.change_level_number.emit(new_level)
	GameState.current_level = new_level

	#Tell everything connected to the signal we changed the level.
	SignalHub.changed_levels.emit(next_level_instance.name)
	#makes the screen fade back in after we change the level.
	#unpause here?
	await screen_transitions.fade_out()

