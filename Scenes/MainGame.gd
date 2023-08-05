extends Control

@onready var tileMap: Rocks = get_node("TileMap");
@onready var worker: Node2D = get_node("TileMap/Worker");

var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	followTimer.connect("timeout", followTime);
	followTimer.wait_time = 0.5;
	add_child(followTimer);
	tileMap.connect('cellClicked', targetRock);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func followTime():
	if pathToFollow.is_empty():
		followTimer.stop();
		return
		
	worker.position = pathToFollow[0];
	pathToFollow.remove_at(0);


func targetRock(cell: Vector2i):
	if !tileMap.rocks.has(cell):
		return;

	var fastestPath: PackedVector2Array;
	for neighbour in tileMap.get_surrounding_cells(cell):
		var path: PackedVector2Array = getPath(neighbour);
		if !path.is_empty() && (fastestPath.is_empty() || path.size() < fastestPath.size()):
			fastestPath = path;
		
	if fastestPath != null:
		moveWorker(fastestPath);


func moveWorker(path: PackedVector2Array):
	pathToFollow = path;
	followTimer.start();


func getPath(target: Vector2i):
	return tileMap.astar_grid.get_point_path(tileMap.local_to_map(worker.position), target)
