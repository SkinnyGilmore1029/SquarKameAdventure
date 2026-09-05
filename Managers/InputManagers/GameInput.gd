class_name GameInputManager
extends Node

static var direction :Vector2

static func movement_input(player: MainKame) -> Vector2:
	player.player_data.moving_direction = Vector2.ZERO

	if Input.is_action_pressed('MovingLeft'):
		player.player_data.moving_direction.x -= 1
	if Input.is_action_pressed('MovingRight'):
		player.player_data.moving_direction.x += 1
	if Input.is_action_pressed("MovingDown"):
		player.player_data.moving_direction.y += 1
	if Input.is_action_pressed('MovingUp'):
		player.player_data.moving_direction.y -= 1

	direction = player.player_data.moving_direction
	return direction


static func is_movement_input() ->bool:
	if direction == Vector2.ZERO:
		return false
	return true
