extends Node2D

signal select;

func _on_button_pressed():
	if material == null:
		hilight();
	else:
		delight();
	
func hilight():
	$sprite.material = load("res://modules/units/highlight_material.tres");
	emit_signal("select", self)
	
func delight():
	$sprite.material = null;

func deselect():
	delight();

