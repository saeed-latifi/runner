extends Area2D
@export_enum("bottom","tmiddle","top") var line
@export_range(0,100) var hit = 50

func _init():
	y_sort_enabled = true


func _process(_delta):
	position -= Vector2(SceneInfo.scene_speed,0)
