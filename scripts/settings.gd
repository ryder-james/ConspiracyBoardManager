extends Node


const SETTINGS_FILE_PATH: String = "user://settings.cfg"
const SECTION_PREFS := &"Preferences"


var _config := ConfigFile.new()


func _ready() -> void:
	_config.load(SETTINGS_FILE_PATH)


#region Preference Shortcuts
func set_preff(pref: FloatPref, value: float, save_immediate := true) -> void:
	_set_value(SECTION_PREFS, pref.key, value, save_immediate)


func set_prefb(pref: BoolPref, value: bool, save_immediate := true) -> void:
	_set_value(SECTION_PREFS, pref.key, value, save_immediate)


func get_preff(pref: FloatPref) -> float:
	return _get_value(SECTION_PREFS, pref.key, pref.default_value)


func get_prefb(pref: BoolPref) -> bool:
	return _get_value(SECTION_PREFS, pref.key, pref.default_value)
#endregion Preference Shortcuts


func setf(section: StringName, key: StringName, 
		value: float, save_immediate := true) -> void:
	_set_value(section, key, value, save_immediate)


func getf(section: StringName, key: StringName, default := 0.0) -> float:
	return _get_value(section, key, default)


func _set_value(section: StringName, key: StringName, 
		value: Variant, save_immediate: bool) -> void:
	_config.set_value(section, key, value)
	if save_immediate:
		_config.save(SETTINGS_FILE_PATH)


func _get_value(section: StringName, key: StringName, default: Variant) -> Variant:
	return _config.get_value(section, key, default)
