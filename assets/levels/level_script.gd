class_name LevelScript
extends Timer


export(NodePath) var dice_controller = "DiceController"
export(Vector3) var solved_position = Vector3.ZERO
export(int, 1, 6) var solved_face = 6

export(PackedScene) var next_level


# Called when the node enters the scene tree for the first time
func _ready():
	assert(self.connect("timeout", self, "_on_timeout") == OK)
	dice_controller = get_node_or_null(dice_controller)
	if dice_controller is DiceController:
		assert(dice_controller.connect("move_finished", self, "_on_move_finished") == OK)


func _on_move_finished():
	if dice_controller is DiceController:
		if dice_controller.translation == solved_position and dice_controller.compute_up_face() == 7 - solved_face:
			dice_controller.set_process_input(false)
			self.start()


func _on_timeout():
	if next_level:
		assert(get_tree().change_scene_to(next_level) == OK)
