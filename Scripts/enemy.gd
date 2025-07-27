extends CharacterBody3D

signal Reload

func destroy():
	emit_signal("Reload")
	hide()


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	#if Input.is_action_just_pressed("fireGun"):
		#emit_signal("Reload")
		#destroy()
		pass
