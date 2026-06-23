class_name PickUp
extends Area2D

enum PICKUP_TYPES {CHICKEN, EGG, GOOSE, RAKE, WATERINGCAN}

signal picked_up

@export_category("export varibles")
@export var current_state := PICKUP_TYPES.CHICKEN

var player

@onready var sprite_handle := $SpriteHandle

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.gameplay_state_changed.connect(_pick_up_item)
	
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
		
	

func _on_body_entered(body: Node2D) -> void:
	
	if body == player:
		print ("Player has touched pickup")
		

func _pick_up_item() -> void:
	pass
