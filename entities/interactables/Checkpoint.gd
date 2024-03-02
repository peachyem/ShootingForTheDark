extends Node2D
class_name Checkpoint

@export var spawnpoint = false

func activate():
	GameManager.current_checkpoint = self

func _on_area_2d_area_entered(area):
	if GameManager.current_checkpoint != self && area.get_parent() is Player:
		activate()
