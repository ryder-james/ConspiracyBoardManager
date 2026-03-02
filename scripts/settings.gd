extends Node


signal pref_changed(pref: Preference)


const SETTINGS_FILE_PATH: String = "user://settings.cfg"
const SECTION_PREFS := &"Preferences"


var _config := ConfigFile.new()
var _cached_settings: Dictionary[String, Variant] = {}


func _ready() -> void:
	_config.load(SETTINGS_FILE_PATH)


func save() -> void:
	_config.save(SETTINGS_FILE_PATH)


#region Preference Shortcuts
func set_preff(pref: FloatPref, value: float, save_immediate := true) -> void:
	_set_preference(pref, value, save_immediate)


func set_prefb(pref: BoolPref, value: bool, save_immediate := true) -> void:
	_set_preference(pref, value, save_immediate)


func get_preff(pref: FloatPref) -> float:
	return _get_value(SECTION_PREFS, pref.key, pref.default_value)


func get_prefb(pref: BoolPref) -> bool:
	return _get_value(SECTION_PREFS, pref.key, pref.default_value)


func _set_preference(pref: Preference, value: Variant, 
		save_immediate: bool) -> void:
	_set_value(SECTION_PREFS, pref.key, value, save_immediate)
	pref_changed.emit(pref)
#endregion Preference Shortcuts


#region Typed value access
func setf(section: StringName, key: StringName, 
		value: float, save_immediate := true) -> void:
	_set_value(section, key, value, save_immediate)


func getf(section: StringName, key: StringName, default := 0.0) -> float:
	return _get_value(section, key, default)
#endregion


#region Direct value access
func _set_value(section: StringName, key: StringName, 
		value: Variant, save_immediate: bool) -> void:
	# Update config in memory
	_config.set_value(section, key, value)
	
	# Update cache
	var qual_key := "%s.%s" % [section, key]
	_cached_settings[qual_key] = value
	
	# Apply to file if requested
	if save_immediate:
		save()


func _get_value(section: StringName, key: StringName, default: Variant) -> Variant:
	var qual_key := "%s.%s" % [section, key]
	if _cached_settings.has(qual_key):
		return _cached_settings[qual_key]
	_cached_settings[qual_key] = _config.get_value(section, key, default)
	return _config.get_value(section, key, default)
#endregion
