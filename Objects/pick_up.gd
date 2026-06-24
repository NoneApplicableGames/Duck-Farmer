class_name PickUp
extends Area2D

enum PICKUP_TYPES {CHICKEN, EGG, GOOSE, RAKE, WATERINGCAN}

signal picked_up

@export_category("export varibles")
@export var current_state := PICKUP_TYPES.CHICKEN

var player_character
var player_button_prompt
var player_touching : bool = false

@onready var sprite_handle := $SpriteHandle

func _ready() -> void:
	player_character = get_tree().get_first_node_in_group("player")
	
	player_button_prompt = get_tree().get_first_node_in_group("button_prompt")
	
	match current_state:
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
		
	


func _unhandled_input(event: InputEvent) -> void:

func _on_body_entered(body: Node2D) -> void:
	
	if body == player_character:
		print("Player has touched the pickup.")
		player_button_prompt.show()

func _on_body_exited(body: Node2D) -> void:
	
	if body == player_character:
		print("Player stopped touching the pickup.")
		player_button_prompt.hide()
