extends Node2D

var gameReport: GameReport = GameReport.new();
# Called when the node enters the scene tree for the first time.
func _ready():
	$map.camera = $Camera2D;
	gameReport.fromFile();
	renderMap(gameReport)
	
func renderMap(setGameReport: GameReport):
	gameReport = setGameReport;
	for coordinate in gameReport.getFogedCoordinates():
		var c = Vector2(
			coordinate["x"],
			(coordinate["y"]+coordinate["x"])/2,
		);
		print(c);
		var newNode = $hexExample.duplicate();
		newNode.position = $map.getAbsPosition(c);
		newNode.get_node("sprite").texture = load("res://images/hexes/%s.png" % gameReport.getTerrainByCoordinates(coordinate));
		newNode.get_node("sprite").modulate = Color(1,1,1,0.3);
		newNode.get_node("Label").text = "%s  %s\n%s  %s" % [c["x"],c["y"], coordinate["x"], coordinate["y"]];
		newNode.get_node("Label").text = "%s  %s" % [coordinate["x"], coordinate["y"]];
		
		newNode.show();
		$hexes.add_child(newNode);
		
		
	for coordinate in gameReport.getHexCoordinates():
		var c = Vector2(
			coordinate["x"],
			(coordinate["y"]+coordinate["x"])/2,
		);
		print(c);
		var newNode = $hexExample.duplicate();
		newNode.position = $map.getAbsPosition(c);
		newNode.get_node("sprite").texture = load("res://images/hexes/%s.png" % gameReport.getTerrainByCoordinates(coordinate));
		newNode.get_node("Label").text = "%s  %s\n%s  %s" % [c["x"],c["y"], coordinate["x"], coordinate["y"]];
		newNode.get_node("Label").text = "%s  %s" % [coordinate["x"], coordinate["y"]];
		newNode.show();
		$hexes.add_child(newNode);
	$Camera2D.position = $hexes.get_child(0).position;


func _on_map_mouse_over_new_tile(c):
	#$selected.set_position ( $map.getAbsPosition(c));
	print("=",c);
	print($map.getAbsPosition(c));
