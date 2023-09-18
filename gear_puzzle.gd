extends Node2D

var snapped_gear = []

func _process(delta):
	if snapped_gear.size() == 6:
		var gears = get_tree().get_nodes_in_group("Gears")
		for i in gears:
			i.get_node("AnimationPlayer").current_animation = "Rotate"
			i.get_node("AnimationPlayer").play()
	else:
		var gears = get_tree().get_nodes_in_group("Gears")
		for i in gears:
			i.get_node("AnimationPlayer").pause()
