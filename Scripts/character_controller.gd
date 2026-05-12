extends CharacterBody2D
class_name CharacterController

## Class dedicated to handling the player character, their movement and accociated states.

@export_category("Physics Variables")
@export var walk_speed : float = 0.0
@export var run_speed : float = 0.0


func _physics_process(delta: float) -> void:
	var move_direction : Vector2
	move_direction.x = Input.get_axis("Move_Left","Move_Right")
	move_direction.y = Input.get_axis("Move_Up","Move_Down")
	
	
	self.velocity= move_direction * walk_speed
	move_and_slide()
	
