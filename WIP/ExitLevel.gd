extends Area2D




func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Player":
		get_tree().change_scene("res://MainMenu.tscn")


