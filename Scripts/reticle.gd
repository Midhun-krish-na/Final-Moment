extends CenterContainer
#making dynamic Reticle
@export var Reticles_line : Array[Line2D]
@export var Player_Controller : CharacterBody3D
@export var Reticle_Speed : float = 0.25
@export var Reticle_Distance : float = 2.0
@export var Player_NodePath: NodePath

#Setting the reticle in center
@export var DOt_Radius : float = 1.0
@export var DOt_Color : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func _draw():
	draw_circle(Vector2(0,0), DOt_Radius, DOt_Color)

func _adjust_reticle_line():
	var vel = Player_Controller.get_real_velocity()
	var orgin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = orgin.distance_to(vel)
	
	#Adjust reticle line position
	Reticles_line[0].position = lerp(Reticles_line[0].position, pos + Vector2(0, -speed * Reticle_Distance), Reticle_Speed) #Top
	Reticles_line[0].position = lerp(Reticles_line[0].position, pos + Vector2(speed * Reticle_Distance, 0), Reticle_Speed) #Right
	Reticles_line[0].position = lerp(Reticles_line[0].position, pos + Vector2(0, speed * Reticle_Distance), Reticle_Speed) #Bottom
	Reticles_line[0].position = lerp(Reticles_line[0].position, pos + Vector2(-speed * Reticle_Distance, 0), Reticle_Speed) #Left
