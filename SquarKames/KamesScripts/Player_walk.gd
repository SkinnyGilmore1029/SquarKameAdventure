extends NodeState


@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D
@onready var marker: Marker2D = kame.get_node("TailMarker")

var move_direction: Vector2

var the_moving_states: Dictionary = {
	"up" :"MovingUp",
	"down" : "MovingDown",
	"left" : "MovingLeft",
	"right" : "MovingRight"
}

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var moving: Vector2 = GameInputManager.movement_input(kame)
	var facing_direction: String = handle_kame_direction()

	#handle facing_direction and return
	if facing_direction not in the_moving_states:
		push_warning("%s is not in the_moving_state check Play_walk.gd" % facing_direction)
		handle_tailmarker_position("up")
		animated_sprite.play(the_moving_states["up"])
		kame.velocity = moving * kame.player_data.speed
		kame.move_and_slide()
		return

	#if everything is good use the facing_direction variable
	handle_tailmarker_position(facing_direction)
	animated_sprite.play(the_moving_states[facing_direction])

	kame.velocity = moving * kame.player_data.speed
	kame.move_and_slide()

func _on_next_transitions() -> void:
	if GameInputManager.movement_input(kame) == Vector2.ZERO:
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()

func handle_kame_direction() -> String:
	var input_direction := kame.player_data.moving_direction
	if input_direction == Vector2.ZERO:
		return kame.player_data.player_direction

	if abs(input_direction.x) > abs(input_direction.y):
		kame.player_data.player_direction = "right" if input_direction.x > 0 else "left"
	else:
		kame.player_data.player_direction = "down" if input_direction.y > 0 else "up"

	return kame.player_data.player_direction

func handle_tailmarker_position(direction: String) -> void:
	var new_vec: Vector2 = kame.player_data.tail_positions[direction]
	kame.player_data.tail_direction = new_vec
	marker.position = kame.player_data.tail_direction
