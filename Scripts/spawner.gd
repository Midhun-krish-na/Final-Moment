extends Node2D

@onready var Shadow_zombie = preload("res://Scene/Shadow_zombie.tscn") # Load the zombie scene


func _ready() -> void:
	randomize() # Seed the random number generator
	$Timer.start() # Start the timer when the scene is ready

func _on_timer_timeout() -> void:
	var zombie = Shadow_zombie.instantiate() # Create an instance of Shadow_zombie
	zombie.position = self.global_position # Set the position of the zombie
	get_parent().add_child(zombie) # Add the zombie to the parent node
	
	# Set a new random wait time for the timer
	$Timer.wait_time = randf_range(10.0, 25.0) # Random time between 1 and 5 seconds
	$Timer.start() # Restart the timer with the new interval
