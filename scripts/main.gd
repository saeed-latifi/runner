extends Node

@onready var game_progress = SceneInfo.game_progress

const first_level = "res://scenes/levels/first_level.tscn"

func _ready():
	SceneInfo.on_new_scene()


func _on_start_pressed():	
	get_tree().change_scene_to_file(first_level)


func _on_exit_pressed():
	get_tree().quit()


func _on_re_start_pressed():
	SceneInfo.game_progress = SceneInfo.DEFAULT_GAME_PROGRESS
	SceneInfo.save_progress()
	SceneInfo.load_progress()
	get_tree().change_scene_to_file(first_level)
