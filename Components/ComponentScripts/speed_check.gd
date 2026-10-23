extends RayCast2D

func _physics_process(_delta: float) -> void:
	if not is_colliding():
		return

	var hit_area := get_collider() as Area2D
	if hit_area == null:
		return

	var other_vehicle := hit_area.get_parent() as RespawningEnemyLogic
	var parent_vehicle := get_parent() as RespawningEnemyLogic
	if other_vehicle == null or parent_vehicle == null:
		return

	var gap := global_position.distance_to(get_collision_point())
	var too_close := gap < 50.0 # Tune this distance

	if (
		too_close
		and other_vehicle.direction == parent_vehicle.direction
		and other_vehicle.vehicle_speed < parent_vehicle.vehicle_speed
	):
		parent_vehicle.vehicle_speed = other_vehicle.vehicle_speed
