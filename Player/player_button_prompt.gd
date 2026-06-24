extends AnimatedSprite2D

signal toggle_visibility(shown : bool)
signal change_prompt_button(new_prompt)

var button_sprites := preload("res://Button Prompts/button_prompts.tres")
var controller_connected := Input.get_connected_joypads() == null

var interact_prompt

func _ready() -> void:
	self.hide()

func _change_visibility() -> void:
	pass
