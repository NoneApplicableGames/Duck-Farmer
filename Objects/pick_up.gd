class_name PickUp
extends Area2D

enum PICKUP_TYPES {CHICKEN, EGG, GOOSE, RAKE, WATERINGCAN}

signal picked_up
signal change_character_state(new_state : CharacterController.PLAYER_GAMEPLAY_STATES)

@export_category("export variables")
@export var current_pickup_type := PICKUP_TYPES.CHICKEN

var player_character
var player_button_prompt
var player_touching : bool = false

@onready var sprite_handle := $SpriteHandle

func _ready() -> void:
	player_character = get_tree().get_first_node_in_group("player")
	player_button_prompt = get_tree().get_first_node_in_group("button_prompt")
	
	change_animation()
	

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") && player_touching == true:
		_pick_up_item()

func _on_body_entered(body: Node2D) -> void:
	
	if body == player_character:
		print("Player has touched the pickup.")
		player_button_prompt.show()
		player_touching = true

func _on_body_exited(body: Node2D) -> void:
	
	if body == player_character:
		print("Player stopped touching the pickup.")
		player_button_prompt.hide()
		player_touching = false


func _pick_up_item() -> void:
	if not player_character:
		return
		
	# 1. Keep track of what is CURRENTLY on the ground before we change anything
	var item_on_ground = current_pickup_type
	var player_state = player_character.current_gameplay_state
	var empty_state = CharacterController.PLAYER_GAMEPLAY_STATES.EMPTY
	
	# 2. Update the ground item to what the player was holding (if they were holding something)
	if player_state != empty_state:
		match player_state:
			CharacterController.PLAYER_GAMEPLAY_STATES.CHICKEN:
				current_pickup_type = PICKUP_TYPES.CHICKEN
			CharacterController.PLAYER_GAMEPLAY_STATES.GOOSE:
				current_pickup_type = PICKUP_TYPES.GOOSE
			CharacterController.PLAYER_GAMEPLAY_STATES.RAKE:
				current_pickup_type = PICKUP_TYPES.RAKE
			CharacterController.PLAYER_GAMEPLAY_STATES.EGG:
				current_pickup_type = PICKUP_TYPES.EGG
			CharacterController.PLAYER_GAMEPLAY_STATES.WATER_CAN:
				current_pickup_type = PICKUP_TYPES.WATERINGCAN
				
		# Visual update to show the ground item has successfully changed
		change_animation() 
		
	# 3. Give the player the item that WAS on the ground (using our cached variable)
	match item_on_ground:
		PICKUP_TYPES.CHICKEN:
			player_character.current_gameplay_state = CharacterController.PLAYER_GAMEPLAY_STATES.CHICKEN
		PICKUP_TYPES.GOOSE:
			player_character.current_gameplay_state = CharacterController.PLAYER_GAMEPLAY_STATES.GOOSE
		PICKUP_TYPES.EGG:
			player_character.current_gameplay_state = CharacterController.PLAYER_GAMEPLAY_STATES.EGG
		PICKUP_TYPES.WATERINGCAN:
			player_character.current_gameplay_state = CharacterController.PLAYER_GAMEPLAY_STATES.WATER_CAN
		PICKUP_TYPES.RAKE:
			player_character.current_gameplay_state = CharacterController.PLAYER_GAMEPLAY_STATES.RAKE
			
	# Notify external systems of the change
	picked_up.emit()
	change_character_state.emit(player_character.current_gameplay_state)
 
	# 4. If player's hands were empty, the item is gone. 
	# If they weren't empty, the item stays on the ground as the newly swapped item.
	if player_state == empty_state:
		if player_button_prompt:
			player_button_prompt.hide()
		queue_free()



func change_animation():
	match current_pickup_type:
		PICKUP_TYPES.CHICKEN:
			sprite_handle.play("Chicken_Feed")
		PICKUP_TYPES.EGG:
			sprite_handle.play("Egg")
		PICKUP_TYPES.GOOSE:
			sprite_handle.play("Goose_Feed")
		PICKUP_TYPES.RAKE:
			sprite_handle.play("Rake")
		PICKUP_TYPES.WATERINGCAN:
			sprite_handle.play("Watering_Can")
	
	#print ("Current Gameplay State: ", player_character.current_gameplay_state, "/n Current Animation State: ", player_character.current_animation_state, "/n Current Pickup State:" , self.current_pickup_type)
	
