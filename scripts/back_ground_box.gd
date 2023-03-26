extends Area2D

@export var width : float


func _process(_delta):
	#position -= Vector2(SceneInfo.scene_speed,0)
	position -= Vector2(5,0)
#	pass


