extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Player") || area.get_parent().is_in_group("Player")):
		print("Level complete")
		get_tree().current_scene.emit_signal("level_complete")
