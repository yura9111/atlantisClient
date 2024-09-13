extends Node
class_name SignalsDictionary

var dictionary: Dictionary = {};
signal add;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dictionary = {};
	
func add(c, entity):
	dictionary[c] = entity;
	emit_signal("add", c)

func update(c):
	emit_signal("update", c)
	
func remove(c):
	dictionary.erase(c);
	emit_signal("remove", c)
	
func has():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
