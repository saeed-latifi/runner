extends Node


#phone setting
const SLIDE_SENSITIVITY:= 19

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

#saving info
const PROJECT_DIRECTORY := "user://"
const SAVED_GAME_PROGRESS_FILE_PATH := PROJECT_DIRECTORY + "game_progress.gor"
const DEFAULT_GAME_PROGRESS = {
	"level": 1,
	"best_score": 0,
}
var game_progress: Dictionary 


func _ready():
	#if not DirAccess.dir_exists_absolute(PROJECT_DIRECTORY):
	#	var dir_access = DirAccess.open("user://")
	#	dir_access.make_dir("runner")
	load_progress()
	


func _process(delta):
	if scene_speed <= scene_max_speed:
		scene_speed += delta * scene_accelerationl_ratio
	else: scene_speed = scene_max_speed

	#scene time spawner line slope calc
	# Y = -(0.025) * X + 1.2
	scene_speed_ratio = (-(0.025) * scene_speed) + 1.2
	#print("scene_speed_ratio ",scene_speed_ratio , " ",delta)
	
	# on lose
	if life <= 0:
		is_lose = true

	# on win
	if points >= goal_point:
		is_win = true
		game_progress.level += 1
		game_progress.best_score += points
		goal_point = (game_progress.level * 1000) +1000
		points = 0
		save_progress()


func save_progress() -> void:
	var progress_file =  FileAccess.open(SAVED_GAME_PROGRESS_FILE_PATH,FileAccess.WRITE)
	progress_file.store_var(game_progress)
	progress_file.close()


func load_progress() -> void:
	if not FileAccess.file_exists(SAVED_GAME_PROGRESS_FILE_PATH):
		game_progress = DEFAULT_GAME_PROGRESS
		save_progress()
		
	var progress_file =  FileAccess.open(SAVED_GAME_PROGRESS_FILE_PATH,FileAccess.READ)
	game_progress = progress_file.get_var()
	progress_file.close()
	goal_point = (game_progress.level * 1000) +1000


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
	obstacle_count  = 0
	points = 0
	life  = 5
	platform_state = platform_states.idle
	character_state = character_states.runing
	platform_current_line = platform_lines.bottom
	scene_speed = scene_base_speed
