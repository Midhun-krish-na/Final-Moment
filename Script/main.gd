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
	$ButtonContainer/StartButton.connect("pressed", _on_start_pressed)
	$ButtonContainer/ContinueButton.connect("pressed", _on_continue_pressed)
	$ButtonContainer/SettingButton.connect("pressed", _on_settings_pressed)
	$ButtonContainer/CreditButton.connect("pressed", _on_credits_pressed)
	$ButtonContainer/QuitButton.connect("pressed",_on_quit_pressed )

	#Conect Hover signals for all buttons
	for button in $ButtonContainer.get_children():
		button.connect("mouse_entered", _on_button_hover)

func _on_start_pressed():
	click_sound.play()
	get_tree().change_scene_to_packed(game_sc)
	pass
	

func _on_continue_pressed():
	click_sound.play()
	#Load / Save game logic
	pass

func _on_settings_pressed():
	click_sound.play()
	get_tree().change_scene_to_packed(setting_sc)
	pass
	
func _on_credits_pressed():
	click_sound.play()
	get_tree().change_scene_to_packed(credits_sc)
	pass
	
func _on_quit_pressed():
	click_sound.play()
	get_tree().quit()
	pass

func _on_button_hover():
	hover_sound.play()
