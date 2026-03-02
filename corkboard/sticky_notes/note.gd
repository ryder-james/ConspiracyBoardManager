extends Gui3D


@export var _messy_notes_pref: BoolPref
@export var _messy_rotation_range := Vector2(-3, 3)

@onready var _visuals: Node3D = %Visuals


func _ready() -> void:
	_update_rotation()
	Settings.pref_changed.connect(_on_pref_changed)


func _on_pref_changed(pref: Preference) -> void:
	if pref == _messy_notes_pref:
		_update_rotation()


func _update_rotation() -> void:
	if Settings.get_prefb(_messy_notes_pref):
		var rot_deg := randf_range(_messy_rotation_range.x, _messy_rotation_range.y)
		_visuals.rotation_degrees.z = rot_deg
	else:
		_visuals.rotation_degrees.z = 0
