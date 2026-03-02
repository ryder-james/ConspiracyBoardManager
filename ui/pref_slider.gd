@tool
extends HBoxContainer


@export var _preference: FloatPref
@export var _range := Vector2(0.0, 100.0)
@export var _step := 1.0

@onready var _label: Label = %Label
@onready var _slider: HSlider = %Slider
@onready var _spinner: SpinBox = %Spinner


func _ready() -> void:
	_update_controls()
	
	_slider.value = Settings.get_preff(_preference)
	_spinner.value = _slider.value
	
	_slider.value_changed.connect(_on_slider_value_changed)
	_spinner.value_changed.connect(_on_spinner_value_changed)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	
	_step = min(_step, _range.y)
	
	_update_controls()


func _get_configuration_warnings() -> PackedStringArray:
	if not _preference:
		return ["Slider missing preference!"]
	return []


func _update_controls() -> void:
	if _preference:
		_label.text = _preference.key.capitalize()
		_slider.value = _preference.default_value
		_spinner.value = _preference.default_value
	
	_slider.min_value = _range.x
	_slider.max_value = _range.y
	_slider.step = _step
	
	_spinner.min_value = _range.x
	_spinner.max_value = _range.y
	_spinner.step = _step


func _on_slider_value_changed(new_value: float) -> void:
	_spinner.value = new_value
	Settings.set_preff(_preference, new_value)


func _on_spinner_value_changed(new_value: float) -> void:
	_slider.value = new_value
	Settings.set_preff(_preference, new_value)
