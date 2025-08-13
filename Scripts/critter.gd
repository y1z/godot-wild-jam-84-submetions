extends CharacterBody2D
class_name Critter

#region const
const minimum_speed = 400.0;
const default_target_area:Rect2i = Rect2i(0,0,Constants.default_screen_size.x, Constants.default_screen_size.y)
const default_minimum_distance_from_target:float = 50.0;
#endregion 

#region var
@export_group("VARIABLES")
@export var type : Enums.critter_type =  Enums.critter_type.NONE
@export var target :Vector2 = position 
@export var speed :float = 0 
@export var target_area : Rect2i ;
@export var minimum_distance_from_target:float = 0

var state : Enums.critter_state = Enums.critter_state.free_roam
var rng = RandomNumberGenerator.new()
var collision_shape : RectangleShape2D
#endregion 


#region build-in

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

func _process(_delta: float) -> void:
	match state:
		Enums.critter_state.free_roam:
			free_roam_state()
		Enums.critter_state.clicked_on:
			click_on_state()
			pass
		_:
			push_error("Unhandled case %s" % state)
	pass

func _physics_process(_delta):
	
	match state:
		Enums.critter_state.free_roam:
			physics_free_roam()
			pass
		Enums.critter_state.clicked_on:
			pass
		_:
			push_error("Unhandled case %s" % state)
	pass
#endregion

func gen_random_pos() -> Vector2:
	var result = Vector2(0,0)
	var rand_x_pos = rng.randf_range(0,target_area.size.x)
	var rand_y_pos = rng.randf_range(0,target_area.size.y)
	result.x = rand_x_pos;
	result.y = rand_y_pos;
	return result;

func handle_left_click() -> void:
	var has_been_clicked_on:bool = Util.does_mouse_intersect_with_rect(collision_shape.get_rect() ,self) 
	if has_been_clicked_on:
		state = Enums.critter_state.clicked_on
		pass
	pass

#region state functions
	
func free_roam_state() -> void:
	if target.distance_to(position) < minimum_distance_from_target:
		target = gen_random_pos()
	pass

func physics_free_roam():
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > 10:
		move_and_slide()
	pass

func click_on_state() -> void:
	position = get_global_mouse_position()
	pass

#endregion
