extends CharacterBody2D
class_name Critter

enum critter_type
{
	NONE = 0,
	Safe,
	Danger
}
# region const
const minimum_speed = 400.0;

@export var type : critter_type = critter_type.NONE
@export var direction :Vector2;
@export var target =position 
@export var speed :float = 0 

func _ready() -> void:
	if speed < minimum_speed :
		speed = minimum_speed
	
	
	pass

func _input(event):
	# Use is_action_pressed to only accept single taps as input instead of mouse drags.
	if event.is_action_pressed(&"l_click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	# look_at(target)
	
	if position.distance_to(target) > 10:
		move_and_slide()
