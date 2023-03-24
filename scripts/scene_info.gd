extends Node

# play info
var is_paused = false
var is_win = false
var is_lose = false
var goal_point := 2000
var points := 0
var life  := 5


#character states
const JUMP_VELOCITY := -1000
const GRAVIRTY := 3000
enum  character_states {runing ,jumping}
var   character_state = character_states.runing


#platform states
const PLATFORM_CHANGE_SPEED := 15
const PLATFORM_CHANGE_RATIO := 90
enum  platform_lines { bottom, middle, top }
enum  platform_states {idle, go_up, go_doown}
var   platform_state = platform_states.idle
var   platform_current_line = platform_lines.bottom

var coin_count := 0
var obstacle_count := 0

#scene states
var scene_base_speed := 10.0
var scene_speed := scene_base_speed
var scene_max_speed := 30.0
var scene_speed_ratio := 1.0
var scene_accelerationl_ratio := 0.5


#scene time spawner line slope calc
# Y = -(0.025) * X + 1.2

func _process(delta):
	if scene_speed < scene_max_speed:
		scene_speed += delta * scene_accelerationl_ratio

	scene_speed_ratio = (-(0.025) * scene_speed) + 1.2
	#print("scene_speed_ratio ",scene_speed_ratio , " ",delta)
	
	if life <= 0:
		is_lose = true

	if points >= goal_point:
		is_win = true


func on_go_up(current_position):
	var target_position = current_position
	if platform_state == platform_states.idle :
		if not platform_current_line == platform_lines.top:
			platform_state = platform_states.go_up
			target_position = current_position - PLATFORM_CHANGE_RATIO
		if platform_current_line == platform_lines.bottom:
			platform_current_line = platform_lines.middle
		elif platform_current_line == platform_lines.middle:
			platform_current_line = platform_lines.top
	return target_position


func on_go_down(current_position):
	var target_position = current_position
	if platform_state == platform_states.idle :
		if not platform_current_line == platform_lines.bottom:
			platform_state = platform_states.go_doown
			target_position = current_position + PLATFORM_CHANGE_RATIO
		if platform_current_line == platform_lines.top:
			platform_current_line = platform_lines.middle
		elif platform_current_line == platform_lines.middle:
			platform_current_line = platform_lines.bottom
	return target_position


func on_new_scene():
	is_paused = false
	is_win = false
	is_lose = false
	coin_count = 0
	obstacle_count = 0
	character_state = character_states.runing
	points = 0
	life  = 5
	platform_current_line = platform_lines.bottom
	scene_speed = scene_base_speed