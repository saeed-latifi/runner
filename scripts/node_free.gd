extends Area2D


func _on_area_entered(area):
	if area.is_in_group("buff"):
		print("buff")
		SceneInfo.coin_count -= 1

	if area.is_in_group("obstacle"):
		print("obstacle")
		print(SceneInfo.obstacle_count)
		SceneInfo.obstacle_count -= 1
		print(SceneInfo.obstacle_count)

	area.queue_free()

