extends StaticBody3D
@export var velocity = Vector3(0,0,0)
@export var SPEED = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func setVelocityDirection(newDir: Vector3):
	rotation = newDir
	velocity = Vector3(-1, 0, 0) * SPEED
