extends CharacterBody2D
class_name enemy

var speed = 50
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position.x += (player.position.x - position.x)/speed
		

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
