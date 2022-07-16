class_name DiceController
extends Spatial


signal move_finished

var moving_delay = 0.0

onready var cube = $Cube

onready var left_pivot = $LeftPivot
onready var right_pivot = $RightPivot
onready var forward_pivot = $ForwardPivot
onready var back_pivot = $BackPivot

onready var tween = $Tween

onready var faces = [
	$Cube/FaceOne,
	$Cube/FaceTwo,
	$Cube/FaceThree,
	$Cube/FaceFour,
	$Cube/FaceFive,
	$Cube/FaceSix
]

onready var check_area_left = $CheckAreaLeft
onready var check_area_right = $CheckAreaRight
onready var check_area_forward = $CheckAreaForward
onready var check_area_back = $CheckAreaBack


func _input(event):
	if moving_delay == 0.0:
		if event.is_action_pressed("ui_left") and not check_area_left.colliding:
			self.start_move(left_pivot, Vector3(0, 0, 90))
		elif event.is_action_pressed("ui_right") and not check_area_right.colliding:
			self.start_move(right_pivot, Vector3(0, 0, -90))
		elif event.is_action_pressed("ui_up") and not check_area_back.colliding:
			self.start_move(back_pivot, Vector3(-90, 0, 0))
		elif event.is_action_pressed("ui_down") and not check_area_forward.colliding:
			self.start_move(forward_pivot, Vector3(90, 0, 0))


func _process(delta):
	if moving_delay > 0.0:
		moving_delay = max(moving_delay - delta, 0.0)


func start_move(pivot, angle):
	self.remove_child(cube)
	cube.translation = -pivot.translation
	pivot.add_child(cube)
	tween.interpolate_property(pivot, "rotation_degrees", Vector3.ZERO, angle, 0.5)
	tween.start()
	moving_delay = 0.55
	get_tree().call_group("moves_counter_ui", "increase_count")


func _on_tween_completed(object, _key):
	if object == left_pivot:
		self.finish_move(left_pivot, Vector3.LEFT)
		cube.rotate_z(PI / 2)
	elif object == right_pivot:
		self.finish_move(right_pivot, Vector3.RIGHT)
		cube.rotate_z(-PI / 2)
	elif object == forward_pivot:
		self.finish_move(forward_pivot, Vector3.BACK)
		cube.rotate_x(PI / 2)
	elif object == back_pivot:
		self.finish_move(back_pivot, Vector3.FORWARD)
		cube.rotate_x(-PI / 2)
	emit_signal("move_finished")


func finish_move(pivot, direction):
	pivot.remove_child(cube)
	cube.translation = Vector3.ZERO
	self.translate(direction * 2)
	self.add_child(cube)


func compute_up_face() -> int:
	for i in faces.size():
		if faces[i].global_transform.origin.y == 1:
			return i + 1
	return 0
