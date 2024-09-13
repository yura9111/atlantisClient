class_name RandomGenerator

static func sqrtGenerator(valueA: int, valueB: int):
	var valueMax = max(valueA, valueB);
	var valueMin = min(valueA, valueB);
	var total = int(abs(valueMax - valueMin));
	#var rnd = sqrt( randi() % (total * total) );
	var rnd =  randi() % (total) ;
	rnd += valueMin;
	return rnd;
	
static func random(valueMin: int, valueMax: int):
	var total = 1 + valueMax - valueMin;
	var rnd = randi() % total;
	rnd += valueMin;
	return rnd;
	
static func randomBool() -> bool:
	return random(0,1) == 1;
	
static func getRandomFromArray(ar: Array):
	return ar[randi() % ar.size()];
