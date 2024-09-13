extends Node2D

var initFinished = false;
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

func _ready():
	await get_tree().create_timer(1).timeout
	if initFinished == false:
		init();

func init(gameReport = null):
	initFinished = true;
	if gameReport == null:
		var file = FileAccess.open("res://testData/report-neworigins-v7-56-0.json", FileAccess.READ)
		var content = file.get_as_text()
		gameReport = JSON.parse_string(content);
	var i = 0;
	var structureCount = gameReport["regions"][0]["structures"].size();
	var unitId = 0;
	for unit in gameReport["regions"][0]["units"]:
		if unit.has("own_unit"):
			unitId = unit["number"]
	for structure in gameReport["regions"][0]["structures"]:
		var buildingId = structure["number"];
		var name = structure["name"];
		var newNode = $gateway.duplicate();
		var landName = getLandNameFromStructureName(name);
		newNode.get_node("sprite").texture = load("res://images/hexes/%s.png" % landName);
		newNode.get_node("Button").connect(
			"pressed", 
			func():_on_button_pressed(
				newNode.get_node("Button"),
				func():orders.moveIn(unitId, buildingId)
			)
		);
		newNode.position = Vector2(512,450) + Vector2(440,0).rotated(2*PI * i / structureCount);
		newNode.show();
		$structures.add_child(newNode);
		i = i + 1;
	
func getLandNameFromStructureName(name):
	for landName in terrainTypes:
			if name.contains(landName):
				return landName;

func _on_mage_select(node):
	selected = node;


func _on_button_pressed(btn, orderFunction: Callable):
	if selected == null:
		return;
	var tween = get_tree().create_tween()
	tween.tween_property(selected, "position", Vector2(btn.get_global_position()+btn.get_size()/2), 2);
	selected.deselect();
	selected = null;
	#orders.moveIn(selected.id, btn.id);
	orderFunction.call();
	pass # Replace with function body.


func _on_send_pressed():
	print(orders.getSendFormat(1,2));
