extends Node2D

var is_paused 

@onready var xline = $obstacle_line
@onready var xfloor = $floor

func _ready():
	SceneInfo.on_new_scene()
	is_paused = SceneInfo.is_paused
	xline.get_tree().paused = SceneInfo.is_paused
	xfloor.get_tree().paused = SceneInfo.is_paused
	
func _process(_delta):
	if is_paused != SceneInfo.is_paused:
		is_paused = SceneInfo.is_paused
		xline.get_tree().paused = SceneInfo.is_paused
		xfloor.get_tree().paused = SceneInfo.is_paused
		
