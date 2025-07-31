extends AnimatableBody3D

signal Reload
signal hasNoAmmo
signal hasAmmo



var playerHasAmmo = true
func destroy():
	hide()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if Input.is_action_just_pressed("fireGun") && playerHasAmmo:
		emit_signal("Reload")
		playerHasAmmo = true
		destroy()
	else:
		pass


func _on_player_has_no_ammo() -> void:
	playerHasAmmo = false



func _on_player_has_ammo() -> void:
	playerHasAmmo = true
