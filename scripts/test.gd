extends Area2D

@onready @export var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var width = sprite.texture.get_size() * scale
	print(width)

func _process(_delta):
	position -= Vector2(SceneInfo.scene_speed,0)

