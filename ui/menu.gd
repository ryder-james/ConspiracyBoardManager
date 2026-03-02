extends Control


const NOTE = preload("uid://begqpr3144cr5")

@onready var _preferences_menu: PanelContainer = %Preferences
@onready var _file_popup: PopupMenu = %File
@onready var _edit_popup: PopupMenu = %Edit
@onready var _pref_close_button: Button = %PrefCloseButton


func _ready() -> void:
	_file_popup.id_pressed.connect(_on_file_popup_pressed)
	_edit_popup.id_pressed.connect(_on_edit_popup_pressed)
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


func _on_edit_popup_pressed(id: int) -> void:
	match id:
		0:
			var screen_center := get_viewport_rect().size * 0.5
			var note_position := Utility.screen_point_to_ray(screen_center, 
					true, Global.CORKBOARD_MASK)
			var new_node: Node3D = NOTE.instantiate()
			get_tree().get_first_node_in_group("NoteParent").add_child(new_node)
			new_node.global_position.x = note_position.x
			new_node.global_position.y = note_position.y
			
