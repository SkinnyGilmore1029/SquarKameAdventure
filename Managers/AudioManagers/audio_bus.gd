class_name AudioBusDriver
extends Node

@onready var sound_effects: AudioStreamPlayer = $AudioSFX
@onready var background_music: AudioStreamPlayer = $AudioBG

var power_up_sfx: String = "uid://docsygon52lhx"
var coin_sfx: String = "uid://b3nkmv055570x"
var explsion_sfx: String = "uid://c23jfde7038me"
var death_sfx: String = "uid://voyltcdcqq43"
var tap_sfx: String = "uid://b5xrx1v1yiqca"
var jump_sfx: String = "uid://d1lq2ramm8kte"

var background_music_uid: String = "uid://wd50ruggl1am"


var audio_book: Dictionary[String, Array ] = {
	"Key" : [coin_sfx, .80],
	"OneUps" : [power_up_sfx, .75],
	"Locks" : [explsion_sfx, .85],
	"Death" : [death_sfx, 1.0],
	"Buttons" : [tap_sfx, 1.0],
	"Appear" : [jump_sfx, 1.0],
	"Coin" : [power_up_sfx, 0.5],
	"Mushroom" : [power_up_sfx, .85],
	"Cherries" : [power_up_sfx, 1.2],
	"GreenApple" : [power_up_sfx, .65],
	"Pear" : [power_up_sfx, 1.5]
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
	sound_effects.volume_db = -15.0
	sound_effects.pitch_scale = pitch

	sound_effects.play()


func play_background() -> void:
	background_music.bus = "BackGround"
	background_music.stream = load(background_music_uid)
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
