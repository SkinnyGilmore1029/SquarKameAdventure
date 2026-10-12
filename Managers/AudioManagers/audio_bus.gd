class_name AudioBusDriver
extends AudioStreamPlayer

var audio_book: Dictionary[String, StringName] = {
    "Key" : "res://Assets/Audio/SoundEffects/coin.wav",
    "OneUps" : "res://Assets/Audio/SoundEffects/power_up.wav",
    "Locks" : "res://Assets/Audio/SoundEffects/explosion.wav",
	"Death" : "res://Assets/Audio/SoundEffects/freesound_community-death-103830.mp3",
	"Buttons" : "res://Assets/Audio/SoundEffects/tap.wav",
	"Appear" : "res://Assets/Audio/SoundEffects/jump.wav"
}


func play_sound(sound_name: String) -> void:
	if sound_name not in audio_book:
		push_warning("Sound '%s' not found." % sound_name)
		return

	bus = "SoundEffects"
	stream = load(audio_book[sound_name])
	volume_db = -10.0
	play()