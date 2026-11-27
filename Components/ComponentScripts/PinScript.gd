extends Area2D

@export var node_pin: PinJoint2D
@onready var pinned_body: RigidBody2D = get_parent()
@onready var pinned_body_path: NodePath = pinned_body.get_path()
@onready var my_shape: CollisionShape2D = pinned_body.get_node("CollisionShape2D")
var player: MainKame

var space_eggs: int


func _ready() -> void:
	space_eggs = int(my_shape.shape.radius * 2.0 * my_shape.global_scale.x)
	connect_signals()


func _physics_process(_delta: float) -> void:
	if pinned_body in GameState.attached_pins:
		_keep_behind()

#body_entered Signal.
func pin_to_player(body: Node2D) -> void:
	if body is MainKame:
		player = body
		node_pin.node_a = body.get_path() #Kame
		node_pin.node_b = pinned_body_path #The moveable
		SignalHub.add_pinned_body.emit(pinned_body)

func connect_signals() -> void:
	SignalHub.unpin_joint.connect(_unpin_from_player)
	SignalHub.can_not_move.connect(_offered_up)
	SignalHub.drop_pinned_eggs.connect(_set_new_position)

func _unpin_from_player() -> void:
	node_pin.node_a = ""
	node_pin.node_b = ""
	SignalHub.remove_pinned_body.emit(pinned_body)

func _set_new_position(egg_pos: Dictionary) -> void:
	if not egg_pos.has(pinned_body):
		return

	pinned_body.linear_velocity = Vector2.ZERO
	pinned_body.angular_velocity = 0.0
	pinned_body.global_position = egg_pos[pinned_body]

func _keep_behind() -> void:
	var tail: Marker2D = player.get_node("TailMarker")
	var tail_pos: Vector2 = tail.global_position
	var tail_index: int = _get_my_index()
	var distance: float = (space_eggs + 8) * (tail_index + 1)

	if tail_index == -1:
		push_warning("%s <-- this RigidBody2D does not exist" % pinned_body)
		return

	match player.player_data.player_direction:
		"left":
			pinned_body.global_position = tail_pos + Vector2(distance, 0)
		"right":
			pinned_body.global_position = tail_pos + Vector2(-distance, 0)
		"up":
			pinned_body.global_position = tail_pos + Vector2(0, distance)
		"down":
			pinned_body.global_position = tail_pos + Vector2(0, -distance)

func _get_my_index() -> int:
	return GameState.attached_pins.find(pinned_body)

func _offered_up(body) -> void:
	if body == pinned_body:
		self.set_deferred("monitoring", false)