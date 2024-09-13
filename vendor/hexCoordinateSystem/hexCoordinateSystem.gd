extends Node
class_name HexCoordinateSystem

var HexGrid = preload("res://vendor/gdhexgrid/HexGrid.gd").new();
var HexCell = preload("res://vendor/gdhexgrid/HexCell.gd");
var size = Vector2(15,15);
var constraints = {};

const directionList = ["N", "NE", "SE", "S", "SW", "NW"];

func _init():
	HexGrid.hex_scale = Vector2(256, 256*sqrt(3)) ;
	for x in range(size.x):
		for y in range(size.y):
			var c = Vector2(x,y);
			constraints[c] = null;
			
func has(c):
	return constraints.has(c);
	
func distance(c1, c2):	
	var cell = HexCell.new(c1);
	return cell.distance_to(c2);
	
func getAdjacent(c) -> Array:
#	var adjacentTileList = [];
	var adjacentList = HexCell.new(c).get_all_adjacent();
	var ret = [];
	for adjacent in adjacentList:
		if constraints.has(adjacent.axial_coords):
			ret.append(adjacent.axial_coords);
	return ret;
#		if tiles.has(adjacent.axial_coords):
#			adjacentTileList.append(tiles[adjacent.axial_coords]);
#	return adjacentTileList	
	
#func getAdjacentTilesByDirection(tile) -> Dictionary:
#	var adjacentTileList = {};
#	var adjacentList = HexCell.new(tile.position).get_all_adjacent();	
#	var i = 0;
#	for adjacent in adjacentList:
#		if tiles.has(adjacent.axial_coords):
#			adjacentTileList[i] = tiles[adjacent.axial_coords];
#		else:
#			adjacentTileList[i] = null;
#		i = i + 1;
#	return adjacentTileList;
	
static func reverseDirection(direction):		
	return (direction + 3) % 6;
	
func fromTile(c):
	return HexGrid.get_hex_center(c);
	
func toTile(c):
	return ( HexGrid.get_hex_at(c).axial_coords );
