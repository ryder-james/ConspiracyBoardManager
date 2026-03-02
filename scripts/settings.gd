extends Node


const KEY_ZOOM_SPEED := &"zoomSpeed"
const KEY_PAN_SPEED := &"panSpeed"


var _setting_map: Dictionary[StringName, float]


func set_value(key: StringName, value: float) -> void:
	_setting_map[key] = value


func get_value(key: StringName, default_value: float = 0.0) -> float:
	if _setting_map.has(key):
		return _setting_map[key]
	return default_value
