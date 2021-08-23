# Copyright (c) 2019-2021 community godot germany (members and contributors) - MIT License

extends VBoxContainer

func _on_backbtn_pressed():
	# Wechselt zurück zum (Pausen-)Menu
	var simultaneous_scene
	if has_node("/root/Stage"):
		simultaneous_scene = load("res://UI/Menu/MenuScenes/PausenMenu.tscn").instance()
	else:
		simultaneous_scene = load("res://UI/Menu/MenuScenes/Menu.tscn").instance()
	get_node("../../").queue_free()
	get_tree().get_root().add_child(simultaneous_scene)

func _on_creditsbtn_pressed():
	# Wechselt zum Credits-Menu
	var simultaneous_scene = load("res://UI/Menu/MenuScenes/Credits.tscn").instance()
	$"/root/".add_child(simultaneous_scene)

func _on_rendererbtn_pressed():
	get_node("confirmationDialog").popup()

func _on_confirmationDialog_confirmed():
	get_tree().quit()

func _on_confirmationDialog_popup_hide():
	$rendererbtn.pressed = !$rendererbtn.pressed
