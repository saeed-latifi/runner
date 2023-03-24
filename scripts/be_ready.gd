extends Node2D

@onready var xlevel = $HBoxContainer/level

func _ready():
	xlevel.text = "%s" % [SceneInfo.game_progress.level]

func _process(_delta):
	position -= Vector2(SceneInfo.scene_speed,0)	
	if position.x < -2000:
		queue_free()
