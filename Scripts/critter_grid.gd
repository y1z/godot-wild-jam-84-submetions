extends Node2D

var danger_grid_sprites :Sprite2D
var safe_grid_sprites :Sprite2D 

func _ready() -> void:
	danger_grid_sprites = $"Danger Grid"
	safe_grid_sprites = $"Safe Grid"
	pass


func _process(delta: float) -> void:
	pass
