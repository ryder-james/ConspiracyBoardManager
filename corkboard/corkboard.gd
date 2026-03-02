extends Node3D


const CorkboardPanel = preload("uid://bpqc3durhqkn4")

@export var grid_size := 20
@export var anchor: Node3D


func _process(_delta: float) -> void:
	var center_x: int = _round_to_nearest_multiple(
			roundi(anchor.global_position.x), 
			grid_size
	)
	var center_y: int = _round_to_nearest_multiple(
			roundi(anchor.global_position.y), 
			grid_size
	)
	for child: Node3D in get_children():
		if child is not CorkboardPanel:
			continue
		var panel := child as CorkboardPanel
		panel.global_position.x = center_x + panel.panel_offset.x * grid_size
		panel.global_position.y = center_y + panel.panel_offset.y * grid_size


func _round_to_nearest_multiple(num_to_round: int, multiplier: int) -> int:
	if multiplier == 0:
		return 0
	
	var is_neg := num_to_round < 0
	var abs_num := absi(num_to_round)
	
	var result := abs_num + (multiplier / 2)
	result = result - (result % multiplier)
	return -result if is_neg else result
