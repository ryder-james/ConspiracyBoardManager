extends Node3D


@export_group("Zoom")
@export var _min_zoom := 5.0
@export var _default_zoom := 15.0
@export var _max_zoom := 25.0
@export var _zoom_sensitivity := 5.0

var _is_panning := false
var _camera_motion: Vector2

@onready var _zoom := _default_zoom


func _process(delta: float) -> void:
	position.z = _zoom
	
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
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom = max(_zoom - _zoom_sensitivity, _min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom = min(_zoom + _zoom_sensitivity, _max_zoom)
	
	if _is_panning and event is InputEventMouseMotion:
		_camera_motion = event.relative
