class_name LevelScript
extends Spatial


export(NodePath) var dice_controller = "DiceController"
export(Vector3) var solved_position = Vector3.ZERO
export(int, 1, 6) var solved_face = 6


# Called when the node enters the scene tree for the first time
func _ready():
	dice_controller = get_node_or_null(dice_controller)
	if dice_controller is DiceController:
		assert(dice_controller.connect("move_finished", self, "_on_move_finished") == OK)


func _on_move_finished():
	if dice_controller is DiceController:
		if dice_controller.translation == solved_position and dice_controller.compute_up_face() == 7 - solved_face:
			print("Solved")
