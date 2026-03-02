extends Node


const SAVE_PATH := "user://savegame.save"


func save_case() -> void:
	var save_file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_nodes := get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped"
					% node.name)
			continue
		
		if not node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped"
					% node.name)
			continue
		
		var node_data: Dictionary = node.save()
		var json_string := JSON.stringify(node_data)
		save_file.store_line(json_string)


func load_case() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var save_nodes := get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		node.queue_free()
	
	var save_file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string := save_file.get_line()
		
		var json := JSON.new()
		
		var parse_result: Error = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: %s in %s at line %s" % [
				json.get_error_message(),
				json_string,
				json.get_error_line()
			])
			continue
		
		var node_data: Variant = json.data
		
		var new_object: Node3D = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector3(node_data["pos_x"], node_data["pos_y"], 0)
		
		for key: String in node_data.keys():
			if key in ["filename", "parent", "pos_x", "pos_y"]:
				continue
			new_object.set(key, node_data[key])
