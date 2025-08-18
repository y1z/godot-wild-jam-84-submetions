extends Node2D
var critter_template :PackedScene = preload("uid://bwksi02isilta")
var critter_danger :PackedScene = preload("uid://dh5k032kukcr5" )
var critter_count :int= 0;

func _ready() -> void:
	var error_code := EventBus.critter_count_down.connect(on_criter_count_down)
	if error_code != OK:
		printerr("error code [%s]" % error_code)
	critter_count = 0;
	for i in range(1,10):
		var critter_temp:Node;
		if i % 2 == 0:
			critter_temp = critter_template.instantiate()
		else:
			critter_temp = critter_danger.instantiate()
			
		add_child(critter_temp)
		critter_count += 1;
		pass
	pass 


@warning_ignore_start("unused_parameter")
@warning_ignore_start("return_value_discarded")
func _process(delta: float) -> void:
	if critter_count < 1:
		get_tree().reload_current_scene()
		pass
	
	pass
@warning_ignore_restore("return_value_discarded")
@warning_ignore_restore("unused_parameter")

func on_criter_count_down(should_count_down:bool)->void:
	if should_count_down != true :
		return;
	critter_count -= 1;
	pass
