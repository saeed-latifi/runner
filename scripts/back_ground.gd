extends Node2D

@export var tile_box : PackedScene 
@export var tiles: Array[PackedScene] = []
@onready var line := $sprite_line
@export var first_spawn_position : int =3000


var last_width := 0.0


func _ready():	
	tile_generate(true)

	

func tile_generate(is_first:bool):	
	if not tiles.is_empty():
		var tile  = tiles[0].instantiate()
		var tile_width  = tile.texture.get_width()  * tile.scale.x
		var tile_height = tile.texture.get_height() * tile.scale.y
		var box  = tile_box.instantiate()
		last_width = tile_width
		
		
		box.call_deferred("add_child",tile)
		if "width" in box:
			box.width = tile_width

		if is_first:
			box.position = Vector2(first_spawn_position ,0)
		else : 
			var child = line.get_child(line.get_child_count()-1)
			if child:
				print(child.position.x , last_width )
				box.position = Vector2(child.position.x + last_width ,0)
		
		
#		print("box.position.x " , box.position.x)
		
		is_first = false
		line.call_deferred("add_child",box)
#		print("width ", box.width)


func _on_killer_area_entered(area):
	area.queue_free()


func _on_spawner_area_entered(area):
	tile_generate(false)
