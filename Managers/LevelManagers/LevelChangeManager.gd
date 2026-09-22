class_name LevelChangeManager
extends Node


var level_scenes: Dictionary[int,String] = {
	1 : "res://TheLevels/LevelScenes/Level1.tscn",
	2 : "res://TheLevels/LevelScenes/Level2.tscn"
}



func change_level(new_level: int, spawn_location: Vector2) -> void:
	#check the dictionary first.
	#don't waste time making variables if invalid entry.
	if new_level not in level_scenes:
		push_warning("Level %d not in level_scenes dictionary in LevelChangeManger.gd." % new_level)
		return

	#Get the Level Parent Node
	var levelsnode = get_node("/root/MainGame/Levels")

	#Delete current level node
	if levelsnode.get_child_count() > 0:
		levelsnode.get_child(0).queue_free()

	#Instantiate the New Level.
	var next_level := load(level_scenes[new_level])
	var next_level_instance = next_level.instantiate()

	#Put the new level in the Levels Node in MainGame.
	levelsnode.add_child(next_level_instance)

	#change the players spawn postion
	PlayerGlobals.spawn_position = spawn_location
	SignalHub.change_level_number.emit(new_level)
	GameState.current_level = new_level

	#Tell everything connected to the signal we changed the level.
	SignalHub.changed_levels.emit(next_level_instance.name)
