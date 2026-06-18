class_name title_screen
extends Control

var main_game
var current_scene : main.GAME_STATES

signal change_game_state(new_scene : PackedScene)

func _on_start_game_button_pressed() -> void:
	current_scene = main.GAME_STATES.DEBUG_LEVEL
	_call_for_scene_change()

func _on_settings_button_pressed() -> void:
	current_scene = main.GAME_STATES.SETTINGS_MENU
	_call_for_scene_change()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _call_for_scene_change():
	change_game_state.emit(current_scene)

func _ready() -> void:
	# find the main node and connect the change game state to it. This will allow us to emit a signal when the buttons are pressed telling main to change scenes
	main_game = get_tree().get_first_node_in_group("main")
	main_game.change_game_state.connect(_call_for_scene_change)
