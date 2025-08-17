extends Node

class ClickedWithCreatureData:
	var global_mouse_pos :Vector2 
	var critter : ClassData.CritterData
	

signal clicked_with_creature(data :ClickedWithCreatureData)

signal critter_count_down(should_count_down:bool)
