class_name GameInputManager
extends Node

static var direction: Vector2 = Vector2.ZERO

static func movement_input(player: MainKame) -> Vector2:
	direction = Input.get_vector("MovingLeft", "MovingRight", "MovingUp", "MovingDown")
	player.player_data.moving_direction = direction
	return direction


static func is_movement_input() ->bool:
	if direction == Vector2.ZERO:
		return false
	return true
