extends Node2D
class_name Checkpoint

@export var spawnpoint = false

func activate():
	GameManager.current_checkpoint = self

func _on_area_2d_area_entered(area: Area2D):
	if (area.is_in_group("Player") || (area.get_parent().is_in_group("Player"))):
		activate()
