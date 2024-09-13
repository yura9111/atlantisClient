@tool
extends NinePatchRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var text = "": set = setText
@export var value = 50: set = setValue
@export var maxValue = 100: set = setMaxValue


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func add(val):
	var newValue = value + val;
	setValue(newValue);
	
func setText(val):
	text = val
	$Label.text = val;

func setValue(val):
	value = val
	if(value > maxValue):
		value = 0;
	updateProgressBar();

func setMaxValue(val):
	maxValue = val
	updateProgressBar();
	
func updateProgressBar():
	var divide = (1.0 * value ) / maxValue;
	$Panel.anchor_right = divide;
	$Label.text = var_to_str(int(round(divide * 100))) + "%" ;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
