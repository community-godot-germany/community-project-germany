# Copyright (c) 2019-2021 community godot germany (members and contributors) - MIT License

extends KinematicBody

onready var scene_camera = $"../Camera/Camera"
onready var nav = $"../navigation"
const ray_length = 1000
const move_speed = 7
var path = []
var path_index = 0

#------------------------------------------------------------------------------

func _physics_process(delta):
	if path_index < path.size():
		var move_direction = (path[path_index] - translation)
		move_direction.y = 0
		if move_direction.length() < move_speed * delta:
			path_index += 1
			if path_index < path.size():
				_rotate_to_next_pathpoint(path[path_index])
		else:
			move_and_slide(move_direction.normalized() * move_speed, Vector3(0, 1, 0))

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var click_pos = _get_mouse_click_position(event)
		if click_pos != null:
			_set_new_path(click_pos)

#------------------------------------------------------------------------------

func _get_mouse_click_position(event):
	var from = scene_camera.project_ray_origin(event.position)
	var to = from + scene_camera.project_ray_normal(event.position) * ray_length
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to)
	if result:
		return result.position
	else:
		return null

func _set_new_path(click_pos):
	path = nav.get_simple_path(translation, click_pos)
	path_index = 0

func _rotate_to_next_pathpoint(point):
	look_at_from_position(translation, point, Vector3(0,1,0))
