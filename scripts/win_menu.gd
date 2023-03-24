extends CanvasLayer

var main_menu = "res://scenes/main.tscn"
var first_level = "res://scenes/levels/first_level.tscn"

func _process(_delta):
	if SceneInfo.is_win:
		visible = true
		SceneInfo.is_paused = true



func _on_main_pressed():
	SceneInfo.on_new_scene()
	get_tree().change_scene_to_file(main_menu)


func _on_re_start_pressed():
	SceneInfo.on_new_scene()
	get_tree().reload_current_scene()
