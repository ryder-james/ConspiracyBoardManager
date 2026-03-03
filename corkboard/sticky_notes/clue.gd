@tool
extends PanelContainer


signal clue_deleted

@export_color_no_alpha var _normal_color: Color
@export_color_no_alpha var _red_clue_color: Color
@export_multiline var text: String

@onready var _clue_text: TextEdit = %ClueText
@onready var _clue_type_toggle_btn: TextureButton = %ClueTypeToggleBtn
@onready var _trash_btn: TextureButton = %TrashBtn


func _ready() -> void:
	_update_color(_clue_type_toggle_btn.button_pressed)
	
	_clue_type_toggle_btn.toggled.connect(_update_color)
	_trash_btn.pressed.connect(func() -> void: clue_deleted.emit())


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		return
	
	_clue_text.text = text
	_update_color(_clue_type_toggle_btn.button_pressed)


func _update_color(is_red: bool) -> void:
	self_modulate = _red_clue_color if is_red else _normal_color
	_clue_type_toggle_btn.self_modulate = _normal_color if is_red else _red_clue_color
