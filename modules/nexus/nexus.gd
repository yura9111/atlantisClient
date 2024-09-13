extends Node2D

var selected = null;
var orders = Orders.new();
var terrainTypes = [
	"plain",
	"forest",
	"mountain",
	"swamp",
	"jungle",
	"desert",
	"tundra"
]

func init(gameReport):
	pass;
	
func getLandNameFromStructureName(name):
	for landName in terrainTypes:
			if name.contains(landName):
				return landName;

func _ready():
	var file = FileAccess.open("res://testData/report-neworigins-v7-56-0.json", FileAccess.READ)
	var content = file.get_as_text()
	var gameReport = JSON.parse_string(content);
	var i = 0;
	var structureCount = gameReport["regions"][0]["structures"].size();
	for structure in gameReport["regions"][0]["structures"]:
		var buildingId = structure["number"];
		var name = structure["name"];
		var newNode = $gateway.duplicate();
		var landName = getLandNameFromStructureName(name);
		newNode.get_node("sprite").texture = load("res://images/hexes/%s.png" % landName);
		newNode.get_node("Button").connect("pressed", func():_on_button_pressed(newNode.get_node("Button")));
		newNode.position = Vector2(512,450) + Vector2(440,0).rotated(2*PI * i / structureCount);
		newNode.show();
		$structures.add_child(newNode);
		i = i + 1;

func _on_mage_select(node):
	selected = node;


func _on_button_pressed(btn):
	if selected == null:
		return;
	var tween = get_tree().create_tween()
	tween.tween_property(selected, "position", Vector2(btn.get_global_position()+btn.get_size()/2), 2);
	selected.deselect();
	selected = null;
	#orders.moveIn(selected.id, btn.id);
	orders.moveIn(963, 1);
	pass # Replace with function body.


func _on_send_pressed():
	print(orders.getSendFormat(1,2));
