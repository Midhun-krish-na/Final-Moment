extends Node3D

@export var MainMenu : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"UI's/BoxContainer/HBoxContainer/VBoxContainer/MainMenu".connect("pressed",_on_pressed_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed_menu():
	get_tree().change_scene_to(MainMenu)
