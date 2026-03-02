extends Gui3D


@export var _messy_notes_pref: BoolPref
@export var _messy_rotation_range := Vector2(-3, 3)

var _is_holding := false
var _is_dragging := false
var _start_pos: Vector3
var _start_mouse_pos: Vector3
var _move_delta: Vector3

@onready var _visuals: Node3D = %Visuals


#region Built-in Virtual Methods
func _ready() -> void:
	super._ready()
	
	_update_rotation()
	Settings.pref_changed.connect(_on_pref_changed)


func _process(_delta: float) -> void:	
	if _is_dragging:
		global_position = _start_pos + _move_delta


func _mouse_input_event(camera: Camera3D, event: InputEvent, 
		event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	super._mouse_input_event(camera, event, event_position, normal, shape_idx)
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("select"):
			_is_holding = true
			_start_pos = global_position
			_start_mouse_pos = Utility.mouse_cast(true, Global.CORKBOARD_MASK)
			_move_delta = Vector3.ZERO
		elif event.is_action_released("select"):
			_is_holding = false
			if not _is_dragging:
				print("Edit note")
			_is_dragging = false
	elif event is InputEventMouseMotion and _is_holding:
		_is_dragging = true
		var current_pos := Utility.mouse_cast(true, Global.CORKBOARD_MASK)
		_move_delta = current_pos - _start_mouse_pos
		_move_delta.z = 0
#endregion


func save() -> Dictionary:
	var save_dict := {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
	}
	
	return save_dict


func _on_pref_changed(pref: Preference) -> void:
	if pref == _messy_notes_pref:
		_update_rotation()


func _update_rotation() -> void:
	if Settings.get_prefb(_messy_notes_pref):
		var rot_deg := randf_range(_messy_rotation_range.x, _messy_rotation_range.y)
		_visuals.rotation_degrees.z = rot_deg
	else:
		_visuals.rotation_degrees.z = 0
