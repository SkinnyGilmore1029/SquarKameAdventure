extends NodeState

@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D

var the_idle_states: Dictionary[String,String] = {
	"up" :"IdleUp",
	"down" : "IdleDown",
	"left" : "IdleLeft",
	"right" : "IdleRight"
}


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	if GameInputManager.movement_input(kame) != Vector2.ZERO:
		transition.emit("Walk")


func _on_enter() -> void:
	if kame.player_data.player_direction not in the_idle_states:
		push_warning("%s is not one of the four directions check player_idle.gd" % kame.player_data.player_direction)
		animated_sprite.play(the_idle_states["up"])
	animated_sprite.play(the_idle_states[kame.player_data.player_direction])


func _on_exit() -> void:
	animated_sprite.stop()
