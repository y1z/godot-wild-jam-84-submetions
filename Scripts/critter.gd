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
# endregion 

@export_group("VARIABLES")
@export var type : critter_type = critter_type.NONE
@export var direction :Vector2;
@export var target :Vector2 = position 
@export var speed :float = 0 

var collision_shape : RectangleShape2D;

func _ready() -> void:
	collision_shape = %"Critter Hitbox".shape;
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
	#collision_shape.get_rect().get
	
	if collision_shape.get_rect().has_point(to_local(get_global_mouse_position()) ):
		print("is inside rectangle")
		pass
	
	if position.distance_to(target) > 10:
		move_and_slide()
