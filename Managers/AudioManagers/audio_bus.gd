class_name AudioBusDriver
extends Node

@onready var sound_effects: AudioStreamPlayer = $AudioSFX
@onready var background_music: AudioStreamPlayer = $AudioBG


var audio_book: Dictionary[String, Array ] = {
	"Key" : ["res://Assets/Audio/SoundEffects/coin.wav", .80],
	"OneUps" : ["res://Assets/Audio/SoundEffects/power_up.wav", .75],
	"Locks" : ["res://Assets/Audio/SoundEffects/explosion.wav", .85],
	"Death" : ["res://Assets/Audio/SoundEffects/freesound_community-death-103830.mp3", 1.0],
	"Buttons" : ["res://Assets/Audio/SoundEffects/tap.wav", 1.0],
	"Appear" : ["res://Assets/Audio/SoundEffects/jump.wav", 1.0],
	"Coin" : ["res://Assets/Audio/SoundEffects/power_up.wav", 0.5],
	"Mushroom" : ["res://Assets/Audio/SoundEffects/power_up.wav", .85],
	"Cherries" : ["res://Assets/Audio/SoundEffects/power_up.wav", 1.2],
	"GreenApple" : ["res://Assets/Audio/SoundEffects/power_up.wav", .65],
	"Pear" : ["res://Assets/Audio/SoundEffects/power_up.wav", 1.5]
}

func _ready() -> void:
	pass

func play_sound(sound_name: String) -> void:
	if sound_name not in audio_book:
		push_warning("Sound '%s' not found." % sound_name)
		return
	var load_string: String = audio_book[sound_name][0]
	var pitch: float = audio_book[sound_name][1]
	sound_effects.bus = "SoundEffects"
	sound_effects.stream = load(load_string)
	sound_effects.volume_db = -5.0
	sound_effects.pitch_scale = pitch

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
