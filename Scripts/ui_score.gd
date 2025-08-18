extends Control


var ui_score:Label;
var ui_panel:Panel

@export_group("VARIABLES")
@export var score_count:int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_score =$Label
	ui_panel = $Panel
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
