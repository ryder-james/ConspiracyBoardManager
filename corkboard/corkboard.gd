extends Node3D


const CORKBOARD_PANEL = preload("uid://0v71yhdp0sx1")

@export var grid_size := 20
@export var side_length := 5
@export var anchor: Node3D


func _ready() -> void:
	if get_child_count() != side_length * side_length:
		for child in get_children():
			child.queue_free()
		for i in side_length * side_length:
			var panel: Node3D = CORKBOARD_PANEL.instantiate()
			add_child(panel)


func _process(_delta: float) -> void:
	var center_x: int = _round_to_nearest_multiple(
			roundi(anchor.global_position.x), 
			grid_size
	)
	var center_y: int = _round_to_nearest_multiple(
			roundi(anchor.global_position.y), 
			grid_size
	)
	for child_index: int in get_child_count():
		var panel: Node3D = get_child(child_index)
		var offset_x := (child_index % side_length) - (side_length / 2)
		var offset_y := (child_index / side_length) - (side_length / 2)
		panel.global_position.x = center_x + offset_x * grid_size
		panel.global_position.y = center_y + offset_y * grid_size


func _round_to_nearest_multiple(num_to_round: int, multiplier: int) -> int:
	if multiplier == 0:
		return 0
	
	var is_neg := num_to_round < 0
	var abs_num := absi(num_to_round)
	
	var result := abs_num + (multiplier / 2)
	result = result - (result % multiplier)
	return -result if is_neg else result
