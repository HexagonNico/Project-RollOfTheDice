class_name MultipleSolutionLevel
extends Timer


export(Array, NodePath) var dices = []
export(Array, Vector3) var solved_positions = []
export(Array, int, 1, 6) var solved_faces = []

export(PackedScene) var next_level

var solved = []


func _ready():
	assert(self.connect("timeout", self, "_on_timeout") == OK)
	for i in dices.size():
		dices[i] = get_node(dices[i])
		assert(dices[i].connect("move_finished", self, "_on_move_finished", [dices[i]]) == OK)
		solved.append(false)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		assert(get_tree().reload_current_scene() == OK)


func _on_move_finished(dice: DiceController):
	for i in solved_positions.size():
		if dice.translation == solved_positions[i] and dice.compute_up_face() == 7 - solved_faces[i]:
			dice.set_process_input(false)
			solved[i] = true
	for val in solved:
		if not val:
			return
	self.start()


func _on_timeout():
	if next_level:
		assert(get_tree().change_scene_to(next_level) == OK)
	else:
		assert(get_tree().change_scene("res://assets/title_screen/title_screen.tscn") == OK)
