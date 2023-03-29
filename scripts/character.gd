extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var detector = $detector/CollisionShape2D

var is_hit = false

func _process(_delta):
	match SceneInfo.platform_current_line:
		SceneInfo.platform_lines.bottom : z_index = 7
		SceneInfo.platform_lines.middle : z_index = 5
		SceneInfo.platform_lines.top    : z_index = 3


func _physics_process(delta):
	var idle_platform = SceneInfo.platform_state == SceneInfo.platform_states.idle

	if not is_on_floor():
		animation_player.play("jump")
		velocity.y += SceneInfo.GRAVIRTY * delta
		SceneInfo.character_state=SceneInfo.character_states.jumping
	else:
		SceneInfo.character_state=SceneInfo.character_states.runing
		
		if is_hit:
			animation_player.play("hit")
		else:
			animation_player.play("run")

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and idle_platform and (not is_hit):
		velocity.y = SceneInfo.JUMP_VELOCITY	


	move_and_slide()


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		velocity.y = SceneInfo.JUMP_VELOCITY


func _on_detector_area_entered(area):
	if ("line" in area) and (SceneInfo.platform_current_line == area.line):
		if area.is_in_group("buff"):
			print("point")
			SceneInfo.points += area.point
			SceneInfo.coin_count -= 1
			area.queue_free()

		if area.is_in_group("obstacle") and (not is_hit):
			#print("obstacle")
			on_play_hit() 
			SceneInfo.life -= 1
			SceneInfo.scene_speed = SceneInfo.scene_base_speed

func on_play_walk():
	animation_player.play("run")
	sprite.modulate.a = 1
	is_hit = false


func on_play_hit():
	sprite.modulate.a = 0.5
	animation_player.play("hit")
	is_hit = true
