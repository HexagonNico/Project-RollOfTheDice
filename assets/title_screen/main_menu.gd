class_name MainMenu
extends Control


export(PackedScene) var first_level


func _on_play():
	assert(get_tree().change_scene_to(first_level) == OK)
