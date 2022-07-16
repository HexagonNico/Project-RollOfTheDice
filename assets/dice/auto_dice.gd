class_name AutoDice
extends DiceController


onready var timer = $Timer


# Called when the node enters the scene tree for the first time
func _ready():
	assert(timer.connect("timeout", self, "_on_timeout") == OK)
	randomize()
	timer.start(rand_range(0.6, 3.0))


func _process(_delta):
	moving_delay = 1.0


func _on_timeout():
	if randf() < 0.5:
		if randf() < 0.5 and not check_area_left.colliding:
			self.start_move(left_pivot, Vector3(0, 0, 90))
		elif not check_area_right.colliding:
			self.start_move(right_pivot, Vector3(0, 0, -90))
	else:
		if randf() < 0.5 and not check_area_back.colliding:
			self.start_move(back_pivot, Vector3(-90, 0, 0))
		elif not check_area_forward.colliding:
			self.start_move(forward_pivot, Vector3(90, 0, 0))
	timer.start(rand_range(0.6, 3.0))
