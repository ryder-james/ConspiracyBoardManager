extends Node3D



@export_group("Pan")
@export var _pan_speed_pref: FloatPref

@export_group("Zoom")
@export var _zoom_speed_pref: FloatPref
@export var _min_zoom := 5.0
@export var _default_zoom := 15.0
@export var _max_zoom := 25.0

var _is_panning := false
var _camera_motion: Vector2

@onready var _zoom := _default_zoom
@onready var camera_3d: Camera3D = %Camera3D


func _ready() -> void:
	get_tree().get_first_node_in_group("Corkboard").anchor = self
	camera_3d.make_current()


func _process(delta: float) -> void:
	position.z = _zoom
	
	if not _is_panning:
		return
	
	var pan_speed: float = Settings.get_preff(_pan_speed_pref)
	global_position.x -= _camera_motion.x * pan_speed * delta
	global_position.y += _camera_motion.y * pan_speed * delta
	_camera_motion = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pan"):
		_is_panning = true
	elif event.is_action_released("pan"):
		_is_panning = false
	
	if event is InputEventMouseButton:
		var zoom_speed: float = Settings.get_preff(_zoom_speed_pref)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom = max(_zoom - zoom_speed, _min_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom = min(_zoom + zoom_speed, _max_zoom)
	
	if _is_panning and event is InputEventMouseMotion:
		_camera_motion = event.relative


func save() -> Dictionary:
	var save_dict := {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"_zoom": _zoom,
	}
	
	return save_dict
