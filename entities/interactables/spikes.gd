extends Node2D

signal hurt_player

func _ready() -> void:
	connect("hurt_player", GameManager.player._on_hurt.bind(self))

func _on_area_2d_area_entered(area):
	print(area)
	if area.is_in_group("Player") || area.get_parent().is_in_group("Player"):
		print("Spike emitting hurt signal")
		emit_signal("hurt_player")

