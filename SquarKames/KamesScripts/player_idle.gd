extends NodeState

@export var kame: MainKame
@export var animated_sprite: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if kame.player_data.player_direction == "up":
		animated_sprite.play('IdleUp')
	if kame.player_data.player_direction == "down":
		animated_sprite.play('IdleDown')
	if kame.player_data.player_direction == "left":
		animated_sprite.play('IdleLeft')
	if kame.player_data.player_direction == "right":
		animated_sprite.play('IdleRight')

func _on_next_transitions() -> void:
	GameInputManager.movement_input(kame)
	if GameInputManager.movement_input(kame) != Vector2.ZERO:
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()

