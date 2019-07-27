#Pausen Menü Script
extends Control

#Aktiviert wenn Szene Geladen wird
func _ready():
	
	#setzt denn pausen modus auf nicht aktiv
	#get_tree().paused = false
	pause_mode = false
	
	#Spielt Die "Beginn" Animation ab
	$Anim.play("Beginn")
	
	#Deaktiviert Die Knöpfe 
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = true

#wird jedes mal Aktiviert wenn ein Knopf gedrückt wird
func _input(event):
	
	#Ist richtig wenn Escape gedrückt wird
	if Input.is_action_just_pressed("ui_cancel"):
		
		#wenn pause_mode ist nicht richtig wird das pausen menü geöffnet
		if not pause_mode:
			PauseEntered()
		#wenn pause_mode ist richtig wird das pausen menü geschlossen
		else:
			PauseExited()


#Aktiviert wenn gecalled
func PauseEntered():
	
	#Spielt Die "Enter" Animation ab
	$Anim.play("Enter")
	
	#Aktiviert Die Knöpfe
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = false
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = false
	
	#setzt denn pausen modus auf aktiv
	#get_tree().paused = true
	pause_mode = true

#Aktiviert wenn gecalled
func PauseExited():
	
	#Spielt Die "Exit" Animation ab
	$Anim.play("Exit")
	
	#Deaktiviert Die Knöpfe
	$CanvasLayer/HBoxContainer/VBoxContainer/Exit.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Options.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Weiter.disabled = true
	$CanvasLayer/HBoxContainer/VBoxContainer/Spiel_Beenden.disabled = true
	
	#setzt denn pausen modus auf nicht aktiv
	#get_tree().paused = false
	pause_mode = false

#wird aktiv wenn Weiter gedrückt wird
func _on_Weiter_pressed():
	#Called Funktion PauseExited()
	PauseExited()


#wird aktiv wenn Spiel_Beenden gedrückt wird
func _on_Spiel_Beenden_pressed():
	#Speichert und Beendet das Spiel
	#Speichert Fortschritt
	
	#Beendet das Spiel
	get_tree().quit()


#wird aktiv wenn func Options gedrückt wird
func _on_Options_pressed():
	#wechselt zum Options Menü
	get_tree().change_scene("res://Settings/Settings.tscn")


func _on_Exit_pressed():
	#wechselt zum MainMenu und Speichert denn fortschritt
	#Speichert Fortschritt
	
	#wechselt zum haupmenü
	get_tree().change_scene("res://Menüs/Menü/Menü.tscn")
