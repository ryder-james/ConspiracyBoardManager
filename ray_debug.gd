extends MeshInstance3D


func _physics_process(_delta: float) -> void:
	global_position = Utility.screen_point_to_ray(true, 4)
