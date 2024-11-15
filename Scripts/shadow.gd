extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta  # Gravity applied while in the air
		if velocity.y < 0:  # While jumping (upwards)
			if not animated_sprite.is_playing() or animated_sprite.animation != "jump":
				animated_sprite.play("jump")  # Play the jump animation while moving up
		elif velocity.y > 0:  # While falling down (if you want to play a different animation while falling)
			if not animated_sprite.is_playing() or animated_sprite.animation != "fall":
				animated_sprite.play("fall")  # Optional, if you want to play a "fall" animation

	# Handle jump when "ui_accept" (spacebar) is pressed and the character is on the floor
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY  # Set the jump velocity (negative to go up)
		if not animated_sprite.is_playing() or animated_sprite.animation != "jump":
			animated_sprite.play("jump")  # Play the jump animation when the jump is initiated


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0 :
			animated_sprite.play("run")
			animated_sprite.flip_h = false
		else :
			animated_sprite.play("run")
			animated_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()
