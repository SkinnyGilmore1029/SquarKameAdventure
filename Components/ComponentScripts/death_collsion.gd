class_name DeathCollision
extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		PlayerGlobals.players_lives -= 1

		#This signal is connected in player_hud.gd
		SignalHub.subtract_one_up.emit(PlayerGlobals.players_lives)

		#This signal is connected in MainKame.gd
		SignalHub.player_died.emit()
