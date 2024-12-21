#Main.gd
extends Control

#Scene Reference sc = scene
@export var game_sc : PackedScene
@export var setting_sc : PackedScene
@export var credits_sc : PackedScene

#Audio
var hover_sound
var click_sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Set Up Audio Player
	hover_sound = AudioStreamPlayer.new()
	click_sound = AudioStreamPlayer.new()
	add_child(hover_sound)
	add_child(click_sound)

#Connect Button Signals
	$VBoxContainer/StartButton.connect("pressed", _on_start_pressed)
	$VBoxContainer/StartButton.connect("pressed", _on_continue_pressed)
	$VBoxContainer/StartButton.connect("pressed", _on_settings_pressed)
	$VBoxContainer/StartButton.connect("pressed", _on_credits_pressed)
	$VBoxContainer/StartButton.connect("pressed",_on_quit_pressed )

	#Conect Hover signals for all buttons
	for button in $VBoxContainer.get_children():
		button.connect("mouse_entered", _on_button_hover)

func _on_start_pressed():
	click_sound.play()
	#get_tree().change_scene_to_packed(game_scene)
	pass
	

func _on_continue_pressed():
	click_sound.play()
	#Load / Save game logic
	pass

func _on_settings_pressed():
	click_sound.play()
	#get_tree().change_scene_to_packed(settings_scene)
	pass
	
func _on_credits_pressed():
	click_sound.play()
	#get_tree().change_scene_to_packed(credits_scene)
	pass
	
func _on_quit_pressed():
	click_sound.play()
	get_tree().quit()
	pass

func _on_button_hover():
	hover_sound.play()
