extends Node3D


var _is_panning := false
var _camera_motion: Vector2


func _process(delta: float) -> void:
	if not _is_panning:
		return
	
	global_position.x -= _camera_motion.x * delta
	global_position.y += _camera_motion.y * delta
	_camera_motion = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pan"):
		_is_panning = true
	elif event.is_action_released("pan"):
		_is_panning = false
	
	if _is_panning and event is InputEventMouseMotion:
		_camera_motion = event.relative
