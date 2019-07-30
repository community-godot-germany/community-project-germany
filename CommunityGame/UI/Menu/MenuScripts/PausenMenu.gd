# Pausenmenu Script
extends Control

#variable an der man erkennt ob das spiel pausiert ist

# Aktiviert, wenn Szene geladen wird
func _ready():
	
	# Setzt den Pausenmodus auf inaktiv
	pause_mode = false
	
	
	# Spielt Die Beginn-Animation ab
	$Anim.play("Beginn")
	
	# Deaktiviert die Knöpfe 
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = true


# Wird jeweils aktiviert, wenn ein Knopf gedrückt wird
func _input(event):
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
	
	# Aktiviert die Knöpfe
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = false
	
	# Setzt den Pausenmodus auf aktiv
	get_tree().paused = true
	pause_mode = 2
	


# Aktiviert, wenn aufgerufen
func PauseExited():
	
	# Spielt Die Exit-Animation ab
	$Anim.play("Exit")
	
	# Deaktiviert die Knöpfe
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = true
	
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
	get_tree().change_scene("res://Settings/Settings.tscn")


func _on_Exit_pressed():
	# Wechselt zum Mainmenu und speichert den Fortschritt
	get_tree().change_scene("res://Menüs/Menü/Menü.tscn")
