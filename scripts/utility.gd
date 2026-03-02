extends Node3D


func mouse_cast(collide_with_areas := false,
		collision_mask: int = 0xFFFFFFFF) -> Vector3:
	return screen_point_to_ray(get_viewport().get_mouse_position(), 
			collide_with_areas, collision_mask)


func screen_point_to_ray(origin: Vector2, collide_with_areas := false, 
		collision_mask: int = 0xFFFFFFFF) -> Vector3:
	var space_state := get_world_3d().direct_space_state
	var camera := get_tree().root.get_camera_3d()
	
	var ray_origin := camera.project_ray_origin(origin)
	var ray_end := ray_origin + camera.project_ray_normal(origin) * 1000
	var params := PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 
			collision_mask)
	params.collide_with_areas = collide_with_areas
	
	var hit := space_state.intersect_ray(params)
	
	return hit.position
