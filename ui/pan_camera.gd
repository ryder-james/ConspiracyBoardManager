extends Node3D


const DEFAULT_ZOOM_SPEED := 5.0
const DEFAULT_PAN_SPEED := 1.0


@export_group("Zoom")
@export var _min_zoom := 5.0
@export var _default_zoom := 15.0
@export var _max_zoom := 25.0

var _is_panning := false
var _camera_motion: Vector2

@onready var _zoom := _default_zoom


func _process(delta: float) -> void:
	position.z = _zoom
	
	if not _is_panning:
		return
	
	var pan_speed: float = Settings.get_value(Settings.KEY_PAN_SPEED, 
			DEFAULT_PAN_SPEED)
	global_position.x -= _camera_motion.x * pan_speed * delta
	global_position.y += _camera_motion.y * pan_speed * delta
	_camera_motion = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pan"):
		_is_panning = true
	elif event.is_action_released("pan"):
		_is_panning = false
	
	if event is InputEventMouseButton:
		var zoom_speed: float = Settings.get_value(Settings.KEY_ZOOM_SPEED,
				DEFAULT_ZOOM_SPEED)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom = max(_zoom - zoom_speed, _min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom = min(_zoom + zoom_speed, _max_zoom)
	
	if _is_panning and event is InputEventMouseMotion:
		_camera_motion = event.relative
