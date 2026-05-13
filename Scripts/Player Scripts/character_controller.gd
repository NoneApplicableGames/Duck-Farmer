extends CharacterBody2D
class_name CharacterController

## Class dedicated to handling player character movement and state machine.

#states for state machine have been seperated out between animations and gameplay state as there are different numbers for both.
enum PLAYER_ANIMATION_STATES {IDLE_EMPTY, WALK_EMPTY, IDLE_CHICKEN, WALK_CHICKEN, IDLE_GOOSE, WALK_GOOSE, IDLE_WATER_CAN, WALK_WATER_CAN, IDLE_RAKE, WALK_RAKE}
enum PLAYER_GAMEPLAY_STATES {EMPTY, CHICKEN, GOOSE, WATER_CAN, RAKE}

#This will probabily require the most testing. Put it at the top just in case.
@export_category("State Machine")

#the player's initial states in state machines have been made an export var to aid with debugging. Note: consider ingame debugging tools later.
@export var inital_animation_state : PLAYER_ANIMATION_STATES =PLAYER_ANIMATION_STATES.IDLE_EMPTY


#Player's physics properties
@export_category("Physics Variables")
@export var walk_speed : float = 0.0
@export var run_speed : float = 0.0


func _physics_process(delta: float) -> void:
	
	# Allows the player to move omnidirectionally without needing multiple cases for 8/4 directional movement.
	var move_direction : Vector2
	move_direction.x = Input.get_axis("Move_Left","Move_Right")
	move_direction.y = Input.get_axis("Move_Up","Move_Down")
	
	#Running has no cooldown like in a PkMn game. No stamina system needed.
	if Input.is_action_pressed("Run"):
		self.velocity= move_direction * run_speed
	else:
		self.velocity= move_direction * walk_speed
	
	# Dont fucking forget to do this at the end of the physics loop or the player wont move.
	move_and_slide()
