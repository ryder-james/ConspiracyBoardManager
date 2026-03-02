@tool
extends HBoxContainer


@export var _setting_name: StringName
@export var _range := Vector2(0.0, 100.0)
@export var _step := 1.0
@export var _default_value := 100.0

@onready var _label: Label = %Label
@onready var _slider: HSlider = %Slider
@onready var _spinner: SpinBox = %Spinner


func _ready() -> void:
	_update_controls()
	
	_slider.value_changed.connect(_on_slider_value_changed)
	_spinner.value_changed.connect(_on_spinner_value_changed)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	
	_default_value = clampf(_default_value, _range.x, _range.y)
	_step = min(_step, _range.y)
	
	_update_controls()


func _update_controls() -> void:
	_label.text = _setting_name.capitalize()
	
	_slider.min_value = _range.x
	_slider.max_value = _range.y
	_slider.step = _step
	_slider.value = _default_value
	
	_spinner.min_value = _range.x
	_spinner.max_value = _range.y
	_spinner.step = _step
	_spinner.value = _default_value


func _on_slider_value_changed(new_value: float) -> void:
	_spinner.value = new_value
	Settings.set_value(_setting_name, new_value)


func _on_spinner_value_changed(new_value: float) -> void:
	_slider.value = new_value
	Settings.set_value(_setting_name, new_value)
