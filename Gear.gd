extends CharacterBody2D

func _physics_process(_delta):
	if is_clicked:
		follow_mouse()

func _on_gui_input(event):
	check_if_clicked(event)
	check_if_click_released(event)

var is_clicked = false

func check_if_clicked(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_clicked = true
			print("is_clicked: ",is_clicked)

func check_if_click_released(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_clicked = false
			print("is_clicked: ",is_clicked)
			snap_handle()

func follow_mouse():
	global_position = get_global_mouse_position()



var is_overlapping = false

func _on_detect_gear_body_entered(body):
	if body != self:
		is_overlapping = true
		print("is_overlapping: ",is_overlapping,", body: ",body)

func _on_detect_gear_body_exited(body):
	if body != self:
		is_overlapping = false
		print("is_overlapping: ",is_overlapping,", body: ",body)



var is_snappable = false
var snapping_pos = []

func _on_detect_gear_area_entered(area):
	print("is_snappable: ",is_snappable,", Snap Area: ",area.get_parent())
	snapping_pos.append(area.get_parent())
	if snapping_pos.is_empty():
		is_snappable = false
	else:
		is_snappable = true

func _on_detect_gear_area_exited(area):
	print("is_snappable: ",is_snappable,", Snap Area: ",area.get_parent())
	snapping_pos.erase(area.get_parent())
	if snapping_pos.is_empty():
		is_snappable = false
	else:
		is_snappable = true



var snapped = false
var old_position:Vector2 = Vector2.ZERO

func snap_handle():
	if not is_overlapping and is_snappable:
		old_position = global_position
		global_position = snapping_pos[0].global_position
		if not is_overlapping:
			snapped = true
			add_to_snapped_gear()
		else:
			global_position = old_position
	else:
		snapped = false
		remove_from_snapped_gear()

func add_to_snapped_gear():
	if get_parent().snapped_gear.has(self):
		pass
	else:
		get_parent().snapped_gear.append(self)

func remove_from_snapped_gear():
	if get_parent().snapped_gear.has(self):
		get_parent().snapped_gear.erase(self)
	else:
		pass
