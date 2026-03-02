extends Control


@onready var _preferences_menu: PanelContainer = %Preferences
@onready var _file_popup: PopupMenu = %File
@onready var _pref_close_button: Button = %PrefCloseButton


func _ready() -> void:
	_file_popup.id_pressed.connect(_on_file_popup_pressed)
	_pref_close_button.pressed.connect(func() -> void:
			_preferences_menu.visible = false)


func _on_file_popup_pressed(id: int) -> void:
	match id:
		0:
			_preferences_menu.visible = true
		1:
			Serializer.save_case()
		2:
			Serializer.load_case()
