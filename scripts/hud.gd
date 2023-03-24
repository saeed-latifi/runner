extends CanvasLayer

@onready var points = $MarginContainer/VBoxContainer/HBoxContainer/point_value
@onready var life  = $MarginContainer/VBoxContainer/HBoxContainer/life_value

func _process(delta):
	points.text = "%s" % [SceneInfo.points]
	life.text = "%s" % [SceneInfo.life]
