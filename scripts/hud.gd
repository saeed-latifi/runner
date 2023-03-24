extends CanvasLayer

@onready var points = $MarginContainer/VBoxContainer/HBoxContainer/point_value
@onready var life   = $MarginContainer/VBoxContainer/HBoxContainer/life_value
@onready var goal   = $MarginContainer/VBoxContainer/HBoxContainer/goal_value
@onready var best   = $MarginContainer/VBoxContainer/HBoxContainer/best_value


func _process(_delta):
	points.text = "%s" % [SceneInfo.points]
	life.text   = "%s" % [SceneInfo.life]
	goal.text   = "%s" % [SceneInfo.goal_point]
	best.text   = "%s" % [SceneInfo.game_progress.best_score]

