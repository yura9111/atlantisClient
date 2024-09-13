extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var coordinateSystem = HexMap.new(10, 4, 100, Vector2(1,1), false, Callable(self, "get_tile"));
var mouseOverOldCoordinates;
var zoom = 1.0;
signal onClick;
signal mouseOverNewTile;
var camera;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var v0 : Vector2 = Vector2(0, 0)
	coordinateSystem = HexMap.new(1, 1, 147.75, v0, true, Callable(self, "get_tile"));
	pass # Replace with function body.
	
func get_tile(tileCoordinates, k : int):
	print(tileCoordinates);
	print(k);
	emit_signal("mouseOverNewTile", tileCoordinates)
	
func _unhandled_input(event):
	var tileCoordinates = coordinateSystem.to_map(camera.get_local_mouse_position() + camera.position);
	#print(tileCoordinates);
	if (Input.is_action_just_released("left_click")):	
		emit_signal("onClick", tileCoordinates)
	else:
		if tileCoordinates != mouseOverOldCoordinates:
			emit_signal("mouseOverNewTile", tileCoordinates)
			mouseOverOldCoordinates = tileCoordinates;
			
	
func init(coordinateSystem):
	self.coordinateSystem = coordinateSystem;

func addSprite(c, sprite):
	sprite.position = coordinateSystem.toTile(c);
	$".".add_child(sprite);
	
func getAbsPosition(c):
	return coordinateSystem.center_of(c);
	
func removeSprite(sprite):
	$".".remove_child(sprite);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
