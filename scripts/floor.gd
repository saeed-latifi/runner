extends StaticBody2D

var target_posotion = position.y

func _process(_delta):
	var is_running = SceneInfo.character_state == SceneInfo.character_states.runing
	var is_idle = SceneInfo.platform_state == SceneInfo.platform_states.idle

	if is_running and is_idle and Input.is_action_just_pressed("go_down"):
		target_posotion = SceneInfo.on_go_down(position.y)

	if is_running and is_idle and Input.is_action_just_pressed("go_up"):
		target_posotion = SceneInfo.on_go_up(position.y)

	if SceneInfo.platform_state == SceneInfo.platform_states.go_up:
		if target_posotion < position.y :
			position.y -= SceneInfo.PLATFORM_CHANGE_SPEED
		else :
			SceneInfo.platform_state = SceneInfo.platform_states.idle

	if SceneInfo.platform_state == SceneInfo.platform_states.go_doown :
		if target_posotion > position.y:
			position.y += SceneInfo.PLATFORM_CHANGE_SPEED
		else :
			SceneInfo.platform_state = SceneInfo.platform_states.idle
