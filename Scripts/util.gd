extends Node
# Util

func does_mouse_intersect_with_rect(rect:Rect2,node: Node2D) -> bool:
	return rect.has_point(node.to_local(node.get_global_mouse_position()))
