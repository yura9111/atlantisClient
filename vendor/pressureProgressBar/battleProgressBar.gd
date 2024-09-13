@tool
extends ColorRect
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var height = 20;
var length = 100;
signal battleResolved;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.height = $".".size.y;
	self.length = $".".size.x;
	#change(100, 50, -25);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass	

func change(maxValue, value, change):
	if maxValue == 0:
		maxValue = 1;
	var redX = (value+change) * length / maxValue;
	var changeInPxAbs = abs(change * length / maxValue);
	get_node("green").size = Vector2(redX, height);
	
	get_node("red").position = Vector2(redX, 0);
	get_node("red").size = Vector2(length - redX, height);
	
	if change >= 0:
		get_node("texture").position = Vector2(redX-changeInPxAbs, 0);
	else:
		get_node("texture").position = Vector2(redX, 0);
	get_node("texture").size = Vector2(changeInPxAbs, height);
	$value.text = "%s / %s" % [value, maxValue];
	$change.text = "%s" % change;
	$change.position = Vector2(get_node("texture").position.x, $change.position.y);
	if change == 0:
		$change.hide();
	else:
		$change.show();
