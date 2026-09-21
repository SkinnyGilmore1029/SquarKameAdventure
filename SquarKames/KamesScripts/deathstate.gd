extends NodeState


@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D

var the_death_states: Dictionary = {
	"up" :"DeathUp",
	"down" : "DeathDown",
	"left" : "DeathLeft",
	"right" : "DeathRight"
}


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		kame.global_position = kame.player_data.spawn_position
		kame.player_data.players_lives -= 1
		SignalHub.subtract_one_up.emit(kame.player_data.players_lives)
		get_tree().paused = false
		transition.emit("Idle")


func _on_enter() -> void:
	get_tree().paused = true
	if kame.player_data.player_direction not in the_death_states:
		push_warning("%s is not one of the four directions check deathstate.gd" % kame.player_data.player_direction)
		animated_sprite.play(the_death_states["up"])
	animated_sprite.play(the_death_states[kame.player_data.player_direction])


func _on_exit() -> void:
	animated_sprite.stop()
