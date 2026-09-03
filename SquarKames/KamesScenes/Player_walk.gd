extends NodeState


@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D

var move_direction: Vector2

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var moving: Vector2 = GameInputManager.movement_input(kame)
	var facing_direction: String = handle_kame_direction()
	if facing_direction == "up":
		animated_sprite.play('MovingUp')
	elif facing_direction == "down":
		animated_sprite.play('MovingDown')
	elif facing_direction == "left":
		animated_sprite.play('MovingLeft')
	elif facing_direction == "right":
		animated_sprite.play('MovingRight')



	kame.velocity = moving * kame.speed
	kame.move_and_slide()

func _on_next_transitions() -> void:
	if GameInputManager.movement_input(kame) == Vector2.ZERO:
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()

func handle_kame_direction() -> String:
	if kame.moving_direction == Vector2(1,0):
		kame.player_direction = "right"
	elif kame.moving_direction == Vector2(-1,0):
		kame.player_direction = "left"
	elif kame.moving_direction == Vector2(0,-1):
		kame.player_direction = "up"
	elif kame.moving_direction == Vector2(0,1):
		kame.player_direction = "down"
	return kame.player_direction
