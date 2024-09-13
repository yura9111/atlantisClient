@tool
extends TextureButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var text: String = "": set = set_text
@export var greyscale: bool = false: set = set_greyscale

func set_text(val:String):
	text = val;
	$Label.text = text;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_greyscale(value): 
	greyscale = value;
	if value:
		$button2.material = load("res://vendor/shaders/greyscale.tres");
	else:
		$button2.material = null;
		#self[property] = value;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
