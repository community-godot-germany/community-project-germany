# Copyright (c) 2019-2021 community godot germany (members and contributors) - MIT License

extends VBoxContainer

func _on_Exit_Button_pressed():
	get_tree().quit()

func _on_Settings_Button_pressed():
	var simultaneous_scene = load("res://UI/Menu/MenuScenes/Settings.tscn").instance()
	get_tree().get_root().add_child(simultaneous_scene)
	for node in get_tree().get_root().get_children():
		if node.name != simultaneous_scene.name:
			get_tree().get_root().get_node(node.name).queue_free()

func _on_Start_Button_pressed():
	var simultaneous_scene = load("res://Main.tscn").instance()
	get_tree().get_root().add_child(simultaneous_scene)
	for node in get_tree().get_root().get_children():
		if node.name != simultaneous_scene.name:
			get_tree().get_root().get_node(node.name).queue_free()
