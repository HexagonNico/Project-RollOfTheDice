class_name MuteAudioButton
extends Button


# Called when the node enters the scene tree for the first time
func _ready():
	assert(self.connect("toggled", self, "_on_toggled") == OK)


func _on_toggled(value: bool):
	MusicPlayer.playing = !value
