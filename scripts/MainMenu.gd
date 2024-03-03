extends Node2D

signal level_complete

func _ready():
	connect("level_complete", GameManager._on_level_complete.bind("MainMenu"))

func _on_play_pressed():
	emit_signal("level_complete");
