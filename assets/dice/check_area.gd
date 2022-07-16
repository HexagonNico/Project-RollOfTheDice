class_name CheckArea
extends Area


var colliding = false


# Called when the node enters the scene tree for the first time
func _ready():
	assert(self.connect("area_entered", self, "_on_area_entered") == OK)
	assert(self.connect("area_exited", self, "_on_area_exited") == OK)


func _on_area_entered(_area):
	self.colliding = true


func _on_area_exited(_area):
	self.colliding = false
