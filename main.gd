extends Node3D



func _ready():
	$Player.rotation = Vector3(0,0,0)

func _physics_process(delta: float):
	
	var mousePosition = get_viewport().get_mouse_position()
	if !Input.is_action_pressed("MouseEsc"):
		get_viewport().warp_mouse(get_viewport().size/2)
		$Player.rotate_y(-(mousePosition.x - (get_viewport().size.x / 2)) / 450)
		$Player.turnCamera((mousePosition.y - (get_viewport().size.y / 2)) / 450)
	
	var direction = Vector3.ZERO
	
	
