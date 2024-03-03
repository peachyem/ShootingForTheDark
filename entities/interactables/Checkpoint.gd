extends Node2D
class_name Checkpoint

@export var spawnpoint = false

func _ready() -> void:
	if GameManager.current_checkpoint == null:
		self.activate()

func activate():
	if (GameManager.current_checkpoint != null):
		GameManager.current_checkpoint.deactivate()
	$AnimationPlayer.play("activate")
	GameManager.current_checkpoint = self

func _on_area_2d_area_entered(area: Area2D):
	if (area.is_in_group("Player") || (area.get_parent().is_in_group("Player"))):
		activate()

func deactivate():
	$AnimationPlayer.play("RESET")
