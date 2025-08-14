extends Node

class ClickedWithCreatureData:
	var global_mouse_pos :Vector2 
	var critter : Critter
	

signal clicked_with_creature(data :ClickedWithCreatureData)
