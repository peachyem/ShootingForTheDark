extends Node

var preloadedScenes := {
	"MainMenu" : preload("res://levels/MainMenu.tscn"),
	"Level0" : preload("res://levels/level_0.tscn"),
	"Level1" : preload("res://levels/level_1.tscn"),
	"Level2" : preload("res://levels/level_2.tscn"),
	"Level3" : preload("res://levels/level_3.tscn"),
	"Level4" : preload("res://levels/level_4.tscn"),
	"Level5" : preload("res://levels/level_5.tscn"),
	"Level6" : preload("res://levels/level_6.tscn"),
	"Level7" : preload("res://levels/level_7.tscn")
}

var sceneList := ["MainMenu", "Level0", "Level1", "Level2", "Level3", "Level4", "Level5", "Level6", "Level7"]

var current_checkpoint : Checkpoint
var player : Player

func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func load_scene(sceneName: String):
	var newScene = preloadedScenes[sceneName]
	
	if (newScene == null):
		newScene = preloadedScenes["MainMenu"]
	
	get_tree().change_scene_to_packed(newScene)
	
	while (get_tree().current_scene == null):
		await get_tree().process_frame

	get_tree().current_scene.connect("level_complete", _on_level_complete.bind(sceneName))
	
func get_next_scene(curSceneName: String) -> String:
	print("getting", curSceneName)
	var where:= sceneList.find(curSceneName)
	print(where)
	if (where == -1 || where == sceneList.size() - 1):
		return "MainMenu"
	
	print(sceneList[where + 1])
	
	return sceneList[where + 1]

func _on_level_complete(levelName : String) -> void:
	print(levelName)
	var nextLevel := get_next_scene(levelName)
	load_scene(nextLevel)
