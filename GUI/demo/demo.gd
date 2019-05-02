# Copyright © 2018-2019 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Control

onready var last_launch := $"LastLaunch/Label" as Label
onready var player_name := $"LastLaunch/PlayerName/LineEdit" as LineEdit
onready var view_distance := $"LastLaunch/Driver/CheckButton" as CheckButton

func _ready():
	last_launch.text = \
			"Last Launch (UTC): " \
			+ unix_to_date(SettingsManager.get_value("cache", "misc/last_launch", -1))
	player_name.text = SettingsManager.get_value("user", "player/name")
	if SettingsManager.get_value("system", "rendering/quality/driver/driver_name") == "GLES3":
		view_distance.pressed = true
	else:
		view_distance.pressed = false

	SettingsManager.set_value("cache", "misc/last_launch", OS.get_unix_time())

# Converts an UNIX timestamp to an date string of the form
# YYYY-MM-DD HH:MM:SS.
func unix_to_date(unix_time: int) -> String:
	if unix_time == -1:
		return "Never"
	else:
		var datetime := OS.get_datetime_from_unix_time(unix_time)
		return "{year}-{month}-{day} {hour}:{minute}:{second}" \
				.format({
					year = datetime.year,
					month = str(datetime.month).pad_zeros(2),
					day = str(datetime.day).pad_zeros(2),
					hour = str(datetime.hour).pad_zeros(2),
					minute = str(datetime.minute).pad_zeros(2),
					second = str(datetime.second).pad_zeros(2),
				})


func _on_CheckButton_pressed():
	if get_node("LastLaunch/Driver/CheckButton").is_pressed():
		SettingsManager.set_value("system", "rendering/quality/driver/driver_name", "GLES3")
	else:
		SettingsManager.set_value("system", "rendering/quality/driver/driver_name", "GLES2")


func _on_LineEdit_text_changed(new_text: String) -> void:
	SettingsManager.set_value("user", "player/name", new_text)
