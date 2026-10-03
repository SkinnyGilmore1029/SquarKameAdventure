class_name ScreenTransitions
extends CanvasLayer

@onready var music: AudioStreamPlayer = get_node(
	"../TheAudio/BackgroundMusic"
)

var player_node: Node2D
var kame_playing: MainKame

func _ready() -> void:
	visible = false
	kame_playing = await get_kame_playing()


#I want this one to make the background go from the pure black and words showing not being able to see the level. so black fades in.
func fade_in(level: int) -> void:
	visible = true
	music.stop()
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_DISABLED
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = true
	var transition_tween = create_tween()
	#Grab the value of the current level before changing it. I want to show the last level number on the screen.
	%FadeRect.modulate.a = 0.0
	%LevelLabelsContainer.modulate.a = 0.0
	%LevelCompleteContainer.modulate.a = 0.0
	set_labels(level)
	transition_tween.tween_property(
		%FadeRect,
		"modulate:a",
		1.0,
		2.5
	)

	transition_tween.parallel().tween_property(
		%LevelLabelsContainer,
		"modulate:a",
		1.0,
		2.5
	).set_delay(0.5)


	transition_tween.parallel().tween_property(
		%LevelCompleteContainer,
		"modulate:a",
		1.0,
		2.5
	).set_delay(1.0)
	await transition_tween.finished


#I want this one to make the background go from the pure black and words showing to being able to see the level. so black fades out to level.
func fade_out() -> void:
	visible = true
	var transition_tween = create_tween()
	%LevelLabelsContainer.modulate.a = 1.0
	%LevelCompleteContainer.modulate.a = 1.0
	%FadeRect.modulate.a = 1.0

	transition_tween.tween_property(
		%LevelCompleteContainer,
		"modulate:a",
		0.0,
		2.5
	)

	transition_tween.parallel().tween_property(
		%LevelLabelsContainer,
		"modulate:a",
		0.0,
		2.5
	).set_delay(0.5)


	transition_tween.parallel().tween_property(
		%FadeRect,
		"modulate:a",
		0.0,
		2.5
	).set_delay(1.0)
	await transition_tween.finished
	visible = false
	get_tree().paused = false
	kame_playing.state_machine.process_mode = Node.PROCESS_MODE_ALWAYS
	kame_playing.animated_sprite.process_mode = Node.PROCESS_MODE_ALWAYS
	music.play()

func get_level_name(level: int) -> String:
	if level in GameState.level_names:
		return GameState.level_names[level]
	else:
		return "Unknown Level"

func set_labels(level: int) -> void:
	var current: int = GameState.current_level
	%LevelNumberLabel.text = "LEVEL %d" % level
	%LevelNameLabel.text = get_level_name(level)
	%LastLevelNumberLabel.text = "%d" % (current)

func get_kame_playing() -> MainKame:
	await get_tree().process_frame

	player_node = get_tree().get_current_scene().get_node("PlayerNode")

	if player_node.get_child_count() <= 0:
		push_warning("No Kame found in PlayerNode. Please check the Main scene tree.")
		return null

	return player_node.get_child(0) as MainKame