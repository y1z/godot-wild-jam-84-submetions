extends Node2D

class CritterData extends Resource:
	var type : Enums.critter_type  = Enums.critter_type.NONE
	var state : Enums.critter_state = Enums.critter_state.free_roam
	var target :Vector2 = Vector2(0,0)
	var speed :float = 0 
	var target_area : Rect2i ;
	var minimum_distance_from_target:float = 0
