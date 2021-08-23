# Copyright (c) 2019-2021 community godot germany (members and contributors) - MIT License

extends Control

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)

func _on_return_pressed():
	# Wechselt zurück zum Settings-Menu
	queue_free()
