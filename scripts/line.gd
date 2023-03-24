extends Node2D

const spawner_distance = 3100

@export var obstacles: Array[PackedScene] = []
@export var coin : PackedScene
@export var coin_size: int   = 64

@export_range(10, 90) var  obstacle_spawn_percent         = 90
@export_range(10, 90) var  coin_spawn_percent             = 60
@export var obstacle_spown_delay:                   float = 0.5
@export var obstacle_spown_delay_randomize:         float = 1.0
@export var coine_spown_delay:                      float = 1.0
@export var coin_spown_delay_randomize:             float = 1.0
@export var each_spown_delay:                       float = 0.1
@export var max_obstacle_dencity:                   int   = 50
@export var max_coin_dencity:                       int   = 100


var obstacle_last_spawn := 0.0
var coin_last_spawn     := 0.0
var last_spawn          := 0.0

var obstacle_random_delay = obstacle_spown_delay_randomize
var coin_random_delay     = coin_spown_delay_randomize


func _process(delta):
	obstacle_last_spawn += delta
	coin_last_spawn     += delta
	last_spawn          += delta
	spawner()


func create_obstacle():
	SceneInfo.obstacle_count += 1
	var random = RandomNumberGenerator.new()
	var random_index = random.randi_range(0,obstacles.size()-1)
	var random_line  = random.randi_range(0,2)
	var obstacle_instance = obstacles[random_index].instantiate()
	var spawn_position := Vector2(spawner_distance,-(random_line * SceneInfo.PLATFORM_CHANGE_RATIO))
	obstacle_instance.position = spawn_position
	obstacle_instance.line = random_line
	obstacle_instance.z_index = (3 - random_line) * 2
	call_deferred("add_child",obstacle_instance)


func create_coin_row():
	var random = RandomNumberGenerator.new()
	var random_coin_number = random.randi_range(0,10)
	var random_line  = random.randi_range(0,2)
	for index in range(random_coin_number):
		var coin_instance = coin.instantiate()
		var spawn_position := Vector2(spawner_distance + (index * coin_size) + 10,-(random_line * SceneInfo.PLATFORM_CHANGE_RATIO))
		coin_instance.position = spawn_position
		coin_instance.line = random_line
		coin_instance.z_index = (3 - random_line) * 2
		SceneInfo.coin_count += 1
		call_deferred("add_child",coin_instance)


func spawner():
	if (last_spawn > each_spown_delay) and (SceneInfo.obstacle_count < max_obstacle_dencity) and (obstacle_last_spawn > ((obstacle_spown_delay * SceneInfo.scene_speed_ratio) + (obstacle_random_delay * SceneInfo.scene_speed_ratio))):
		var random = RandomNumberGenerator.new()
		var percent = random.randi_range(0,100)
		obstacle_random_delay = random.randf_range(0,obstacle_spown_delay_randomize)
		if (percent < obstacle_spawn_percent):
			obstacle_last_spawn = 0
			last_spawn = 0
			create_obstacle()

	if (last_spawn > each_spown_delay) and (SceneInfo.coin_count < max_coin_dencity) and (coin_last_spawn > ((coine_spown_delay * SceneInfo.scene_speed_ratio) + (coin_random_delay * SceneInfo.scene_speed_ratio))):
		var random = RandomNumberGenerator.new()
		var percent = random.randi_range(0,100)
		coin_random_delay = random.randf_range(0,coin_spown_delay_randomize)
		if (percent < coin_spawn_percent):
			coin_last_spawn = 0
			last_spawn = 0
			create_coin_row()


func _on_killer_area_entered(area):
	if area.is_in_group("buff"):
		SceneInfo.coin_count -= 1
	if area.is_in_group("obstacle"):
		SceneInfo.obstacle_count -= 1
	area.queue_free()


