extends Node3D


func screen_point_to_ray(collide_with_areas := false, 
		collision_mask: int = 0xFFFFFFFF) -> Vector3:
	var space_state := get_world_3d().direct_space_state
	var mouse_pos := get_viewport().get_mouse_position()
	var camera := get_tree().root.get_camera_3d()
	
	var ray_origin := camera.project_ray_origin(mouse_pos)
	var ray_end := ray_origin + camera.project_ray_normal(mouse_pos) * 1000
	var params := PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 
			collision_mask)
	params.collide_with_areas = collide_with_areas
	
	var hit := space_state.intersect_ray(params)
	
	return hit.position
