extends Node3D

@export var MainMenu : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$UI/ID/MainMenu.connect("pressed",_on_pressed_menu)
	#$UI/ID/Exit.connect("pressed",_on_pressed_Exit)
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed_menu():
	get_tree().change_scene_to_packed(MainMenu)

func _on_pressed_Exit():
	get_tree().quit()
