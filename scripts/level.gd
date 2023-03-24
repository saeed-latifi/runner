extends Node2D

var is_paused 

@onready var line = $line
@onready var floor = $floor

func _ready():
	is_paused = SceneInfo.is_paused
	print("is_paused " ,is_paused)
	line.get_tree().paused = SceneInfo.is_paused
	floor.get_tree().paused = SceneInfo.is_paused
	
func _process(delta):
	if is_paused != SceneInfo.is_paused:
		is_paused = SceneInfo.is_paused
		line.get_tree().paused = SceneInfo.is_paused
		floor.get_tree().paused = SceneInfo.is_paused
		
