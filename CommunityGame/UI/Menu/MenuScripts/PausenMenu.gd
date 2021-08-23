# Copyright (c) 2019-2021 community godot germany (members and contributors) - MIT License

extends Control

# Aktiviert, wenn Szene geladen wird
func _ready():
	# Setzt den Pausenmodus auf inaktiv
	PauseExited()
	# Spielt Die Beginn-Animation ab
	$Anim.play("Beginn")

# Wird jeweils aktiviert, wenn ein Knopf gedrückt wird
func _input(_event):
	# Wenn Escape gedrückt wird
	if Input.is_action_just_pressed("ui_cancel"):
		# Wenn bisher noch nicht pausiert wurde, wird jedenfalls jetzt das Pausenmenu geöffnet
		if not pause_mode:
			PauseEntered()
		# Wenn bisher schon das Pausenmenu offen war, dann wird jetzt nicht mehr pausiert
		else:
			PauseExited()

# Aktiviert, wenn aufgerufen
func PauseEntered():
	# Spielt Die Enter-Animation ab
	$Anim.play("Enter")
	# Setzt den Pausenmodus auf aktiv
	get_tree().paused = true
	pause_mode = true
	for node in $CanvasLayer/HBoxContainer/VBoxContainer.get_children():
		$CanvasLayer/HBoxContainer/VBoxContainer.get_node(node.name).disabled=false

# Aktiviert, wenn aufgerufen
func PauseExited():
	# Spielt Die Exit-Animation ab
	$Anim.play("Exit")
	for node in $CanvasLayer/HBoxContainer/VBoxContainer.get_children():
		$CanvasLayer/HBoxContainer/VBoxContainer.get_node(node.name).disabled=true
	# Setzt den Pausenmodus auf inaktiv
	get_tree().paused = false
	pause_mode = false


# Wird aktiv, wenn "Weiter" gedrückt wird
func _on_Weiter_pressed():
	#Called Funktion PauseExited()
	PauseExited()

# Wird aktiv, wenn "Spiel_Beenden" gedrückt wird
func _on_Spiel_Beenden_pressed():
	# Speichert und beendet das Spiel
	# TODO: Speichere den Fortschritt
	#Beendet das Spiel
	get_tree().quit()

# Wird aktiv, wenn "Options" gedrückt wird
func _on_Options_pressed():
	# Wechselt zum Settings-Menu
	PauseExited()
	var simultaneous_scene = load("res://UI/Menu/MenuScenes/Settings.tscn").instance()
	get_node(".").queue_free()
	get_tree().get_root().add_child(simultaneous_scene)

func _on_Exit_pressed():
	# Wechselt zum Main-Menu
	PauseExited()
	var simultaneous_scene = load("res://UI/Menu/MenuScenes/Menu.tscn").instance()
	get_tree().get_root().add_child(simultaneous_scene)
	for node in get_tree().get_root().get_children():
		if node.name != simultaneous_scene.name:
			get_tree().get_root().get_node(node.name).queue_free()
