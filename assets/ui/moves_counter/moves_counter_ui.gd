class_name MovesCounterUI
extends Control


onready var label = $MarginContainer/Label

var moves_count = 0 setget set_count


func increase_count():
	self.moves_count += 1


func set_count(value: int):
	label.text = "Moves: " + str(value)
	moves_count = value
