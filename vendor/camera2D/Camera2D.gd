extends Camera2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var pressed = false;
var pressedInitialPoint;
signal changeZoom;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _unhandled_input(event):
	if (Input.is_action_pressed("right_click")):
		if(pressed == false):
			pressed = true;
			pressedInitialPoint = get_viewport().get_mouse_position();
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		$".".position += (-pressedInitialPoint + get_viewport().get_mouse_position())/10;#Mouse position relative to the previous position (position at the last frame).
		#print($".".position);
	else:
		pressed = false;
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#zoom
	if (Input.is_action_just_released("wheel_up")):
		if zoom.x > 0.4:
			zoom -= Vector2(0.1, 0.1);
			emit_signal("changeZoom")
	if (Input.is_action_just_released("wheel_down")):
		zoom += Vector2(0.1, 0.1);
		emit_signal("changeZoom")
