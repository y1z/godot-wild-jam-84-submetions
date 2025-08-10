extends Node2D
class_name Critter

enum critter_type
{
	NONE = 0,
	Safe,
	Danger
}

var type : critter_type = critter_type.NONE
