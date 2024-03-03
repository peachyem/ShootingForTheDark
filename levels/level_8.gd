extends Node2D

func _on_level_exit_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Player") || area.get_parent().is_in_group("Player")):
		emit_signal("level_complete")
