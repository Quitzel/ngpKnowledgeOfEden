extends VBoxContainer

signal continueGame
var isShown = false
var sensitivity = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$Label/Sensitivity.value = sensitivity



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !isShown:
		if Input.is_action_just_released("Menu"):
			isShown = true
			show()
	else:
		if Input.is_action_just_released("Menu"):
			isShown = false
			hide()
			
	


func _on_sensitivity_value_changed(value: float) -> void:
	sensitivity = 2 - value


func _on_continue_pressed() -> void:
	emit_signal("continueGame")
	hide()


func _on_quit_pressed() -> void:
	get_tree().quit(0)
