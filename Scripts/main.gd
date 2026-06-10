##Class to handle game states and transitions, destroying and instantiating scenes as and when is needed.

class_name main
extends Node2D

enum GAME_STATES {START_MENU, DEBUG_LEVEL}

signal change_game_scene(new_scene : PackedScene)
signal change_game_state(new_state : GAME_STATES)

# game scenes

var start_menu := preload("res://Scenes/UI/start_menu.tscn").instantiate()
var settings_menu := preload("res://Scenes/UI/settings_menu.tscn").instantiate()
var ingame_ui := preload("res://Scenes/UI/ingame_ui_layers.tscn").instantiate()
var debug_level := preload("res://Scenes/Levels/debug_level.tscn").instantiate()
var player := preload("res://Scenes/player_character.tscn").instantiate()
var farm_house := preload("res://Scenes/Levels/farm_house.tscn").instantiate()

func _ready() -> void:
	%UILayer.add_child(start_menu)
