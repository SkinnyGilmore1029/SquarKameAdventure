extends NodeState


@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D


var the_death_states: Dictionary = {
	"up" :"DeathUp",
	"down" : "DeathDown",
	"left" : "DeathLeft",
	"right" : "DeathRight"
}

#-----------------State Machine Functions-------------

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		kame.global_position = kame.player_data.spawn_position
		kame.player_data.players_lives -= 1

		if kame.player_data.players_lives <= 0:
			get_tree().paused = false
			get_tree().change_scene_to_file(
                GameState.game_over_screen
            )
			return

		SignalHub.subtract_one_up.emit(kame.player_data.players_lives)
		get_tree().paused = false
		transition.emit("Idle")


func _on_enter() -> void:

	#To do: find a way not to fire this every time the player dies, check if the player is pinned to something first.?
	if !GameState.attached_pins.is_empty():
		var egg_positions: Dictionary = {}

		for egg in GameState.attached_pins:
			egg_positions[egg] = egg.global_position

		SignalHub.unpin_joint.emit()
		SignalHub.drop_pinned_eggs.emit(egg_positions)

	get_tree().paused = true

	AudioBus.play_sound("Death")

	if kame.player_data.player_direction not in the_death_states:
		push_warning("%s is not one of the four directions check deathstate.gd" % kame.player_data.player_direction)
		animated_sprite.play(the_death_states["up"])
		return

	#do not use this if warning is pushed.
	animated_sprite.play(the_death_states[kame.player_data.player_direction])

func _on_exit() -> void:
	animated_sprite.stop()





