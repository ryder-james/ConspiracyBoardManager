@tool
extends HBoxContainer


@export var _preference: BoolPref

@onready var _label: Label = %Label
@onready var _check_box: CheckBox = %CheckBox


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	_update_controls()
	_check_box.set_pressed_no_signal(Settings.get_prefb(_preference))
	
	_check_box.toggled.connect(_on_check_box_value_changed)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	
	_update_controls()


func _get_configuration_warnings() -> PackedStringArray:
	if not _preference:
		return ["Toggle missing preference!"]
	return []


func _update_controls() -> void:
	if _preference:
		_label.text = _preference.key.capitalize()


func _on_check_box_value_changed(new_value: bool) -> void:
	Settings.set_prefb(_preference, new_value)
