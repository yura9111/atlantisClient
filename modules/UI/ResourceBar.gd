@tool
extends NinePatchRect
@export var resourceTexture: Texture2D: set = set_resourceTexture
@export var text: String = "22": set = set_text
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
func set_text(val: String):
	text = val;		
	$Label.text = text;

func set_resourceTexture(texture: Texture2D):
	resourceTexture = texture;
	if($wood2):
		print($wood2.texture);
		print(resourceTexture);
		$wood2.texture = resourceTexture;
	#$wood2.texture = resourceTexture;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
