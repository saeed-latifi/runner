extends CharacterBody2D


func _process(_delta):
	match SceneInfo.platform_current_line:
		SceneInfo.platform_lines.bottom : z_index = 7
		SceneInfo.platform_lines.middle : z_index = 5
		SceneInfo.platform_lines.top    : z_index = 3


func _physics_process(delta):
	var idle_platform = SceneInfo.platform_state == SceneInfo.platform_states.idle

	if not is_on_floor():
		velocity.y += SceneInfo.GRAVIRTY * delta
		SceneInfo.character_state=SceneInfo.character_states.jumping
	else:
		SceneInfo.character_state=SceneInfo.character_states.runing

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and idle_platform:
		velocity.y = SceneInfo.JUMP_VELOCITY

	move_and_slide()


func _on_detector_area_entered(area):
	if ("line" in area) and (SceneInfo.platform_current_line == area.line):
		if area.is_in_group("point"):
			print("point")
			SceneInfo.points += area.point
			SceneInfo.coin_count -= 1
			area.queue_free()

		if area.is_in_group("obstacle"):
			print("obstacle")
			SceneInfo.life -= 1
			SceneInfo.scene_speed = SceneInfo.scene_base_speed
			
