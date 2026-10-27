class_name AudioBusDriver
extends Node

@onready var sound_effects: AudioStreamPlayer = $AudioSFX
@onready var background_music: AudioStreamPlayer = $AudioBG


var audio_book: Dictionary[String, String] = {
	"Key" : "res://Assets/Audio/SoundEffects/coin.wav",
	"OneUps" : "res://Assets/Audio/SoundEffects/power_up.wav",
	"Locks" : "res://Assets/Audio/SoundEffects/explosion.wav",
	"Death" : "res://Assets/Audio/SoundEffects/freesound_community-death-103830.mp3",
	"Buttons" : "res://Assets/Audio/SoundEffects/tap.wav",
	"Appear" : "res://Assets/Audio/SoundEffects/jump.wav"
}

func _ready() -> void:
	add_sfx_compressor()

func play_sound(sound_name: String) -> void:
	if sound_name not in audio_book:
		push_warning("Sound '%s' not found." % sound_name)
		return

	sound_effects.bus = "SoundEffects"
	sound_effects.stream = load(audio_book[sound_name])
	sound_effects.volume_db = -10.0
	sound_effects.play()


func play_background() -> void:
	background_music.bus = "BackGround"
	background_music.stream = load("res://Assets/Audio/BackgroundMusic/tatamusic-game-gaming-minecraft-background-music-377647.mp3")
	background_music.volume_db = -20.0
	background_music.pitch_scale = 0.85
	background_music.play()

func add_sfx_compressor()-> void:
	var bus_index = AudioServer.get_bus_index("SoundEffects")

	if bus_index == -1:
		push_warning("SoundEffects is not a found as an AudioBus.")
		return

	var compressor = AudioEffectCompressor.new()
	compressor.threshold = -18.0
	compressor.ratio = 4.0
	AudioServer.add_bus_effect(bus_index, compressor)
