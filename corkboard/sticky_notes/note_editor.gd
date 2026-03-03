extends Control


const CLUE = preload("uid://po0lcdykfxt3")


@onready var _edit_btn: TextureButton = %EditBtn
@onready var _description_text: TextEdit = %DescriptionText
@onready var _description_display: RichTextLabel = $MarginContainer/Window/MarginContainer/Content/MainContent/Container/DescriptionDisplay
@onready var _clue_list: VBoxContainer = %ClueList
@onready var _add_clue_btn: TextureButton = %AddClueBtn


func _ready() -> void:
	_edit_btn.toggled.connect(_toggle_edit)
	_add_clue_btn.pressed.connect(_add_clue)


func _toggle_edit(is_editing: bool) -> void:
	if not is_editing:
		_description_display.text = _description_text.text
	_description_text.visible = is_editing
	_description_display.visible = not is_editing


func _add_clue() -> void:
	var new_clue: Control = CLUE.instantiate()
	new_clue.clue_deleted.connect(func() -> void: new_clue.queue_free())
	_clue_list.add_child(new_clue)
