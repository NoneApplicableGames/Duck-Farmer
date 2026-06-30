##Class to handle game states and transitions, destroying and instantiating scenes as and when is needed.

class_name main
extends Node2D

enum GAME_STATES {START_MENU, SETTINGS_MENU, DEBUG_LEVEL, FARM_HOUSE, FIELD, YARD}

@export_category("Game State")
@export var current_game_state : GAME_STATES = GAME_STATES.START_MENU

signal change_game_state(new_state : GAME_STATES)

# game scenes

var start_menu := preload("res://UI/Menus/start_menu.tscn").instantiate()
var settings_menu := preload("res://UI/Menus/settings_menu.tscn").instantiate()
var ingame_ui := preload("res://UI/ingame_ui_layers.tscn").instantiate()
var debug_level := preload("res://Levels/debug_level.tscn").instantiate()
var player := preload("res://Player/player_character.tscn").instantiate()
var farm_house := preload("res://Levels/farm_house.tscn").instantiate()
var field := preload("res://Levels/field.tscn").instantiate()
var yard := preload("res://Levels/yard.tscn").instantiate()
var watermark := preload("res://UI/water_mark.tscn").instantiate()

func _ready() -> void:
	_load_new_scene(current_game_state)

#function to delete the currently loaded menu/level and spawn the new level depending on the current game state.
func _load_new_scene(new_scene : GAME_STATES):
	#print(new_scene)
	#find the currently loaded menu and removes it as a child
	#we dont queue free since that doesnt allow us to add it back later
	var current_scene = get_tree().get_first_node_in_group("scene")
	%UILayer.remove_child(current_scene)
	
	#work out what scene needs to be loaded next
	#add the new scene as a child of main if level, add as child of canvasLayer if Menu/UI element
	match new_scene:
		GAME_STATES.START_MENU:
			%UILayer.add_child(start_menu)
			start_menu.change_game_state.connect(_load_new_scene)
		GAME_STATES.SETTINGS_MENU:
			%UILayer. add_child(settings_menu)
			settings_menu.change_game_state.connect(_load_new_scene)
		GAME_STATES.DEBUG_LEVEL:
			self.add_child(debug_level)
			%UILayer.add_child(watermark)
	
	
