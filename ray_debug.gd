extends MeshInstance3D


func _physics_process(_delta: float) -> void:
	global_position = Utility.mouse_cast(true, Global.CORKBOARD_MASK)
