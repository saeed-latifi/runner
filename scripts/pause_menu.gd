extends CanvasLayer

var main_menu = "res://scenes/main.tscn"

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if not (SceneInfo.is_win or SceneInfo.is_lose):
			visible = !visible
			SceneInfo.is_paused = !SceneInfo.is_paused


func _on_resume_pressed():
	visible = false
	SceneInfo.is_paused = false


func _on_main_pressed():
	get_tree().change_scene_to_file(main_menu)
