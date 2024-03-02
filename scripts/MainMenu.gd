extends Node2D

@onready var transition = $Transition
var level1 = preload("res://levels/level_1.tscn")



func _on_play_pressed():
	transition.play("fade_out") 



func _on_transition_animation_finished(_anim_name):
	
	get_tree().change_scene_to_packed(level1) 
