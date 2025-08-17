extends CharacterBody2D
class_name Critter


#region const
const minimum_speed = 400.0;
const default_target_area:Rect2i = Rect2i(0,0,Constants.default_screen_size.x, Constants.default_screen_size.y)
const default_minimum_distance_from_target:float = 50.0;
#endregion 

#region var
@export_group("VARIABLES")
@export var data:ClassData.CritterData = null

var rng  := RandomNumberGenerator.new()
var collision_shape : RectangleShape2D
#endregion 


#region build-in funcs

func _ready() -> void:
	if data == null:
		data = ClassData.CritterData.new()
		
	collision_shape = %"Critter Hitbox".shape;
	if data.speed < minimum_speed :
		data.speed = minimum_speed
	
	if data.minimum_distance_from_target < 0.1:
		data.minimum_distance_from_target = default_minimum_distance_from_target;
	
	if data.target_area.size.x == 0 && data.target_area.size.y == 0:
		data.target_area = default_target_area
	
	pass

func _input(event:InputEvent) -> void:
	if event.is_action_pressed(&"l_click"):
		handle_left_click()
	pass

func _process(_delta: float) -> void:
	match data.state:
		Enums.critter_state.free_roam:
			free_roam_state()
		Enums.critter_state.clicked_on:
			click_on_state()
		Enums.critter_state.stoped:
			pass
		_:
			push_error("Unhandled case %s" % data.state)
	pass

func _physics_process(_delta:float) -> void:
	
	match data.state:
		Enums.critter_state.free_roam:
			physics_free_roam()
		Enums.critter_state.clicked_on:
			# do nothing on purpose 
			pass
		Enums.critter_state.stoped:
			pass
		_:
			push_error("Unhandled case %s" % data.state)
	pass
#endregion

func gen_random_pos() -> Vector2:
	var result := Vector2(0,0)
	var rand_x_pos := rng.randf_range(0,data.target_area.size.x)
	var rand_y_pos := rng.randf_range(0,data.target_area.size.y)
	result.x = rand_x_pos;
	result.y = rand_y_pos;
	return result;

func handle_left_click() -> void:
	match data.state:
		Enums.critter_state.free_roam:
			var has_been_clicked_on:bool = Util.does_mouse_intersect_with_rect(collision_shape.get_rect() ,self) 
			if has_been_clicked_on:
				data.state = Enums.critter_state.clicked_on
		Enums.critter_state.clicked_on:
			var eventData:EventBus.ClickedWithCreatureData=EventBus.ClickedWithCreatureData.new()
			eventData.critter = data;
			eventData.global_mouse_pos = get_global_mouse_position()
			EventBus.clicked_with_creature.emit(eventData)
	pass

#region state functions
	
func free_roam_state() -> void:
	if data.target.distance_to(position) < data.minimum_distance_from_target:
		data.target = gen_random_pos()
	pass

func physics_free_roam() -> void:
	velocity = position.direction_to(data.target) *data.speed
	
	if position.distance_to(data.target) > 10:
		@warning_ignore_start("return_value_discarded")
		move_and_slide()
		@warning_ignore_restore("return_value_discarded")
	pass

func click_on_state() -> void:
	position = get_global_mouse_position()
	pass

func stoped_state() -> void:
	pass

#endregion
