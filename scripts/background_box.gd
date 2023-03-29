extends Area2D

@export var width : float
@export var speed_multiplier : float = 1

@onready var collider = $collider

func _ready():
	collider.position.x = width

func _process(_delta):
	position -= Vector2(SceneInfo.scene_speed * speed_multiplier, 0)



