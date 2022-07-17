extends AudioStreamPlayer


export(AudioStream) var music2


# Called when the node enters the scene tree for the first time
func _ready():
	var file = File.new()
	if file.file_exists("user://completed"):
		self.stream = music2
	self.play()
