class_name GameInputManager
extends Node

static var direction :Vector2

static func movement_input(player: MainKame) -> Vector2:
	player.moving_direction = Vector2.ZERO

	if Input.is_action_pressed('MovingLeft'):
		player.moving_direction.x -= 1
	if Input.is_action_pressed('MovingRight'):
		player.moving_direction.x += 1
	if Input.is_action_pressed("MovingDown"):
		player.moving_direction.y += 1
	if Input.is_action_pressed('MovingUp'):
		player.moving_direction.y -= 1

	direction = player.moving_direction
	return direction


static func is_movement_input() ->bool:
	if direction == Vector2.ZERO:
		return false
	return true