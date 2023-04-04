extends CanvasLayer

const first_level = "res://scenes/levels/first_level.tscn"

func _on_button_pressed():
	SceneInfo.game_progress.guide_viewed = true

	SceneInfo.save_progress()
