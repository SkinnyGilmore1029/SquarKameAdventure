class_name DeathCollision
extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		#This signal is connected in MainKame.gd
		#This has to be called first to keep the PlayersGlobals synced with the player hub.
		SignalHub.player_died.emit()

		#This signal is connected in player_hud.gd
		SignalHub.subtract_one_up.emit(PlayerGlobals.players_lives)


