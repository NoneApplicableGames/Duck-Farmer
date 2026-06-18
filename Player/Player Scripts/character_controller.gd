extends CharacterBody2D
#Initalise as a class so that other classes can access the enums
class_name CharacterController

## Class dedicated to handling player character movement and state machine.

#states for state machine have been seperated out between animations and gameplay state as there are different numbers for both.
enum PLAYER_ANIMATION_STATES {IDLE_EMPTY, WALK_EMPTY, IDLE_CHICKEN, WALK_CHICKEN, IDLE_GOOSE, WALK_GOOSE, IDLE_WATER_CAN, WALK_WATER_CAN, IDLE_RAKE, WALK_RAKE}
enum PLAYER_GAMEPLAY_STATES {EMPTY, CHICKEN, GOOSE, WATER_CAN, RAKE}

#To notifty other objects if state has changed.
#Arguement should ideally pass the new state to whatever the signal is connected to.
signal animation_state_changed(new_state: PLAYER_ANIMATION_STATES)
signal gameplay_state_changed(new_state: PLAYER_GAMEPLAY_STATES) 

#This will probabily require the most testing. Put it at the top just in case.
@export_category("State Machine")

#the player's initial states in state machines have been made an export var to aid with debugging. Note: consider ingame debugging tools later.
@export var inital_animation_state : PLAYER_ANIMATION_STATES =PLAYER_ANIMATION_STATES.IDLE_EMPTY
@export var initial_gameplay_state : PLAYER_GAMEPLAY_STATES = PLAYER_GAMEPLAY_STATES.EMPTY

#Player's physics properties
@export_category("Physics Variables")
@export var walk_speed : float = 0.0
@export var run_speed : float = 0.0

#Node references
@onready var SpriteHandle = %PlayerSpriteHandle

#enums are read as intergers relating to the key of the state that the dictoary associates them with. we need to have these vars as int to store and access the infomation.

var current_animation_state : int
var current_gameplay_state : int

func _ready() -> void:

	current_animation_state = inital_animation_state
	animation_state_changed.emit(current_animation_state)

func _physics_process(delta: float) -> void:
	
	#According to scope movment needs to be locked to 4 directions. 
	var move_direction : Vector2
	
	if Input.is_action_pressed("Move_Down"):
		move_direction = Vector2.DOWN
	elif Input.is_action_pressed("Move_Up"):
		move_direction = Vector2.UP
	elif Input.is_action_pressed("Move_Left"):
		move_direction= Vector2.LEFT
	elif Input.is_action_pressed("Move_Right"):
		move_direction = Vector2.RIGHT
	
	
	#Running has no cooldown like in a PkMn game. No stamina system needed.
	if Input.is_action_pressed("Run"):
		self.velocity= move_direction * run_speed
	else:
		self.velocity= move_direction * walk_speed
	
	
	change_animation_state(move_direction)
	# Dont fucking forget to do this at the end of the physics loop or the player wont move.
	move_and_slide()

func change_animation_state(move_direction : Vector2):
	
	if move_direction != Vector2.ZERO:
		current_animation_state = PLAYER_ANIMATION_STATES.WALK_EMPTY
	
	else:
		current_animation_state = PLAYER_ANIMATION_STATES.IDLE_EMPTY
	
	if move_direction == Vector2.LEFT:
		%PlayerSpriteHandle.flip_h = true
	elif move_direction == Vector2.RIGHT:
		%PlayerSpriteHandle.flip_h = false
	
	animation_state_changed.emit(current_animation_state)
