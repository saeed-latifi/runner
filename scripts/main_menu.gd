extends Node

@onready var game_progress   = SceneInfo.game_progress
@onready var continue_button = $BoxContainer/VBoxContainer/HBoxContainer/continue

const first_level = "res://scenes/levels/first_level.tscn"
const guid_scene  = "res://component/ui/guid.tscn"


func _ready():
	SceneInfo.on_new_scene()
	if SceneInfo.game_progress.guide_viewed:
		continue_button.visible = true
	else:
		continue_button.visible =false


func _on_start_pressed():
	if SceneInfo.game_progress.guide_viewed:
		get_tree().change_scene_to_file(first_level)
	else:
		get_tree().change_scene_to_file(guid_scene)

func _on_exit_pressed():
	get_tree().quit()


func _on_re_start_pressed():	
	get_tree().change_scene_to_file(guid_scene)
