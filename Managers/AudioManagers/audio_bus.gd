class_name AudioBusDriver
extends AudioStreamPlayer

var audio_book: Dictionary[String, StringName] = {
    "Key" : "res://Assets/Audio/SoundEffects/coin.wav",
    "OneUps" : "res://Assets/Audio/SoundEffects/power_up.wav",
    "Locks" : "res://Assets/Audio/SoundEffects/explosion.wav",
	"Death" : "res://Assets/Audio/SoundEffects/freesound_community-death-103830.mp3"
}


func play_sound(sound_name: String) -> void:
	if sound_name not in audio_book:
		push_warning("Sound '%s' not found." % sound_name)
		return

	stream = load(audio_book[sound_name])
	volume_db = -10.0
	bus = "SoundEffects"
	play()