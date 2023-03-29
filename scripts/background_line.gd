extends Node2D

@export var speed_multiplier: float = 1
@export var custome_z_index: int = 0
@export var first_spawn_position: int = 3000
@export var tile_box: PackedScene 
@export var tiles: Array[PackedScene] = []

@onready var line:= $sprite_line

var last_width := 0.0


func _ready():	
	tile_generate(true)


#TODO random tile feom array
func tile_generate(is_first:bool):
	if not tiles.is_empty():
		#random tile
		var random = RandomNumberGenerator.new()
		var random_index = random.randi_range(0,tiles.size()-1)
		var random_line  = random.randi_range(0,2)
		var tile = tiles[random_index].instantiate()

		# tile position
		var tile_width  = tile.texture.get_width()  * tile.scale.x
		var tile_height = tile.texture.get_height() * tile.scale.y
		tile.position.y = -tile_height
		
		# box create
		var box = tile_box.instantiate()
		box.call_deferred("add_child",tile)
		if "width" in box:
			box.width = tile_width
		if "speed_multiplier" in box:
			box.speed_multiplier = speed_multiplier

		if is_first:
			box.position = Vector2(first_spawn_position ,0)
		else : 
			var last_child = line.get_child(line.get_child_count()-1)
			if last_child:
				box.position = Vector2(last_child.position.x + last_width ,0)

		line.call_deferred("add_child",box)

		# scene info modify
		last_width = tile_width
		is_first = false


func _on_spawner_area_entered(_area):
	tile_generate(false)
