class_name PlayerAnimationHandler
extends AnimatedSprite2D


## A class to handle all the animations for the different states the player can be in during gameplay.

var _animation_frames  := preload("res://Player/Player Sprites/Player_Sprite_Frames.tres")
@onready var player_character = $".."

@export_category("Animation Handler")

func _change_animation_state(_current_animation: CharacterController.PLAYER_ANIMATION_STATES) -> void:
	

	match _current_animation:
		
		CharacterController.PLAYER_ANIMATION_STATES.IDLE_EMPTY:
			self.play("Idle_Empty")
		
		CharacterController.PLAYER_ANIMATION_STATES.IDLE_CHICKEN:
			self.play("Idle_Chicken")
		
		CharacterController.PLAYER_ANIMATION_STATES.IDLE_GOOSE:
			self.play("Idle_Goose")
	
		CharacterController.PLAYER_ANIMATION_STATES.IDLE_WATER_CAN:
			self.play("Idle_Water_Can")
		
		CharacterController.PLAYER_ANIMATION_STATES.WALK_EMPTY:
			self.play("Walk_Empty")
	
		CharacterController.PLAYER_ANIMATION_STATES.WALK_WATER_CAN:
			self.play("Walk_Water_Can")
		
		CharacterController.PLAYER_ANIMATION_STATES.WALK_GOOSE:
			self.play("Walk_Goose")
		
		CharacterController.PLAYER_ANIMATION_STATES.IDLE_RAKE:
			self.play("Idle_Rake")
		
		CharacterController.PLAYER_ANIMATION_STATES.WALK_RAKE:
			self.play("Walk_Rake")
		
		CharacterController.PLAYER_ANIMATION_STATES.WALK_CHICKEN:
			self.play("Walk_Chicken")
	
		_:
			self.play("Idle_Empty")
			print("ANIMATION ERROR: No animation found for current state. Did you spell it correctly?")
