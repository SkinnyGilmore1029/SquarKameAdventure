class_name LevelChangeManager
extends Node


func change_level(new_level: PackedScene, spawn_location: Vector2) -> void:
    #Get the Level Parent Node
    var levelsnode = get_node("/root/MainGame/Levels")

    #Delete current level node
    if levelsnode.get_child_count() > 0:
        levelsnode.get_child(0).queue_free()

    #Instantiate the New Level.
    var level_going_to := new_level.instantiate()

    #Put the new level in the Levels Node in MainGame.
    levelsnode.add_child(level_going_to)
    PlayerGlobals.spawn_position = spawn_location
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