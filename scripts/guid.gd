extends CanvasLayer

const first_level = "res://scenes/levels/first_level.tscn"

func _ready():
	print(SceneInfo.game_progress)

func _on_button_pressed():
	SceneInfo.game_progress = SceneInfo.DEFAULT_GAME_PROGRESS
	SceneInfo.save_progress()
	SceneInfo.load_progress()
	print(SceneInfo.game_progress)
	get_tree().change_scene_to_file(first_level)
