extends Node2D

var danger_grid_sprites :Sprite2D
var safe_grid_sprites :Sprite2D 
var col_shape : RectangleShape2D


@export_group("VARIABLES")
@export var critter_type :Enums.critter_type :
	set(value) : 
		critter_type = value
		select_the_grid_to_show()

func _ready() -> void:
	danger_grid_sprites = $"Danger Grid"
	safe_grid_sprites = $"Safe Grid"
	col_shape = %CollisionShape2D.shape
	
	if critter_type == Enums.critter_type.NONE:
		critter_type = Enums.critter_type.safe
		print("critter_grid get default assigned")
	
	var error_code := EventBus.clicked_with_creature.connect(on_clicked_with_creature)
	
	if error_code != OK:
		printerr("[ERROR] %s" % error_code)
		
	
	select_the_grid_to_show();
	pass


func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"l_click"):
		var thing = Util.does_mouse_intersect_with_rect(col_shape.get_rect(),self)
	pass

func select_the_grid_to_show() -> void:
	if safe_grid_sprites == null or danger_grid_sprites == null:
		return
	
	var should_turn_on_safe_grid:bool = critter_type == Enums.critter_type.safe;
	
	safe_grid_sprites.visible = should_turn_on_safe_grid
	danger_grid_sprites.visible = !should_turn_on_safe_grid
	
	pass

func on_clicked_with_creature(data:EventBus.ClickedWithCreatureData):
	var should_keep_critter_in_grid:bool = col_shape.get_rect().has_point(to_local(data.global_mouse_pos))
	var has_same_critter_type : bool = data.critter.type == critter_type;
	if should_keep_critter_in_grid && has_same_critter_type:
		data.critter.state = Enums.critter_state.stoped
		EventBus.critter_count_down.emit(true)
		var score_increment := EventBus.ScoreIncrement.new();
		score_increment.increament = 10
		EventBus.increment_score.emit(score_increment)
	pass
