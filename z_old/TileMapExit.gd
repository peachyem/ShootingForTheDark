extends TileMap


func _on_TileMapExit_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://MainMenu.tscn")
