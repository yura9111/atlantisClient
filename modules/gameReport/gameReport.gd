class_name GameReport

var data = null;

func getFogedCoordinates():
	var coordinates = [];
	for region in data["regions"]:
		for exitRegion in region["exits"]:
			coordinates.push_back(exitRegion["region"]["coordinates"])
	return coordinates;
	

func getHexCoordinates():
	var coordinates = [];
	for region in data["regions"]:
		coordinates.push_back(region["coordinates"])
	return coordinates;
	
func getTerrainByCoordinates(coordinates):
	var regionCoordinates = null;
	for region in data["regions"]:
		regionCoordinates = region["coordinates"];
		if regionCoordinates == coordinates:
			return region["terrain"]
	#NOW check exits
	for region in data["regions"]:
		for exitRegion in region["exits"]:
			regionCoordinates = exitRegion["region"]["coordinates"];
			if regionCoordinates == coordinates:
				return exitRegion["region"]["terrain"]
	
func fromFile():
	var file = FileAccess.open("res://testData/report-neworigins-v7-56-2.json", FileAccess.READ)
	var content = file.get_as_text()
	var gameReport = JSON.parse_string(content);
	fromJSON(gameReport)
	

func fromJSON(jsonData):
	data = jsonData;
