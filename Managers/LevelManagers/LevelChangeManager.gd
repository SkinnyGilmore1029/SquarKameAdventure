class_name LevelChangeManager
extends Node

#Maybe and enum might be better or switch keys to int so i can add 1 to the current level
var level_scenes: Dictionary ={
	"Level1" : "res://TheLevels/LevelScenes/Level1.tscn",
	"Level2" : "res://TheLevels/LevelScenes/Level2.tscn"
}


#Todo
#change new_level to int
#get current level and add one to it for new level?
func change_level(new_level: String, spawn_location: Vector2) -> void:
	#Get the Level Parent Node
	var levelsnode = get_node("/root/MainGame/Levels")

	#Delete current level node
	if levelsnode.get_child_count() > 0:
		levelsnode.get_child(0).queue_free()

	#Instantiate the New Level.
	var next_level := load(level_scenes[new_level])
	var level_going_to = next_level.instantiate()

	#Put the new level in the Levels Node in MainGame.
	levelsnode.add_child(level_going_to)
	PlayerGlobals.spawn_position = spawn_location
	SignalHub.changed_levels.emit(level_going_to.name)
"""

func change_area(new_area :PackedScene, spawn_location :Vector2) -> void:
    #Get The Worlds Areas parent node.
    var WorldArea = get_node("/root/MainGame/WorldAreas")

    #Get current child scene maybe for future use?
    #var _current_scene = WorldArea.get_child(0)

    #I don't know why there would be more then one child but loop through them and free them all.
    for area in WorldArea.get_children():
        area.queue_free()

    #Make the new scene so i can get in to it.
    var area_going_to := new_area.instantiate()
    WorldArea.add_child(area_going_to)
    SpawnManager.spawn_jesse(spawn_location)
    #print(GameState.All_the_plants)

"""
