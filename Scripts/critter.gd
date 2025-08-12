extends CharacterBody2D
class_name Critter

enum critter_type
{
	NONE = 0,
	safe,
	danger
}

enum critter_state
{
	free_roam,
	clicked_on,
}

#region const
const minimum_speed = 400.0;
const default_target_area:Rect2i = Rect2i(0,0,Constants.default_screen_size.x, Constants.default_screen_size.y)
const default_minimum_distance_from_target:float = 50.0;
#endregion 

#region var
@export_group("VARIABLES")
@export var type : critter_type = critter_type.NONE
@export var target :Vector2 = position 
@export var speed :float = 0 
@export var target_area : Rect2i ;
@export var minimum_distance_from_target:float = 0
var state : critter_state = critter_state.free_roam
var rng = RandomNumberGenerator.new()
#endregion 

var collision_shape : RectangleShape2D;

func _ready() -> void:
	collision_shape = %"Critter Hitbox".shape;
	if speed < minimum_speed :
		speed = minimum_speed
	
	if minimum_distance_from_target < 0.1:
		minimum_distance_from_target = default_minimum_distance_from_target;
	
	if target_area.size.x == 0 && target_area.size.y == 0:
		target_area = default_target_area
	
	pass

func _input(event):
	if event.is_action_pressed(&"l_click"):
		handle_left_click()
	
	pass

func _process(delta: float) -> void:
	if target.distance_to(position) < minimum_distance_from_target:
		target = gen_random_pos()
	pass

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > 10:
		move_and_slide()

func gen_random_pos() -> Vector2:
	var result = Vector2(0,0)
	var rand_x_pos = rng.randf_range(0,target_area.size.x)
	var rand_y_pos = rng.randf_range(0,target_area.size.y)
	result.x = rand_x_pos;
	result.y = rand_y_pos;
	return result;

func handle_left_click() -> void:
	if collision_shape.get_rect().has_point(to_local(get_global_mouse_position()) ):
		print("has been clicked on")
		pass
	pass
