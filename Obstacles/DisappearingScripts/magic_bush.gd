extends StaticBody2D


func bush_done() -> void:
    visible = false
    $CollisionShape2D.set_deferred("disabled", true)
