class_name DeathCollision
extends Area2D


#Don't forget to connect the signal on the New Enemies!!

func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		print("hi")
		#This signal is connected in MainKame.gd
		#This has to be called first to keep the PlayersGlobals synced with the player hub.
		SignalHub.player_died.emit()

		#This signal is connected in player_hud.gd
		SignalHub.subtract_one_up.emit(PlayerGlobals.players_lives)


