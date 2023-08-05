extends Control

@onready var tileMap: Rocks = get_node("TileMap");
@onready var worker: Node2D = get_node("TileMap/Worker");

var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;
var attackTimer = Timer.new();
var isWorkerMining: bool = false;
var targetRock: RockUI;

# Called when the node enters the scene tree for the first time.
func _ready():
	followTimer.connect("timeout", followTime);
	followTimer.wait_time = 0.5;
	add_child(followTimer);

	attackTimer.connect("timeout", attackTime);
	attackTimer.wait_time = 0.2;
	add_child(attackTimer);

	tileMap.connect('cellClicked', moveToAttackRock);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func followTime():
	if pathToFollow.is_empty():
		followTimer.stop();
		isWorkerMining = true;
		attackTimer.start();
		return
		
	worker.position = pathToFollow[0];
	pathToFollow.remove_at(0);


func attackTime():
	if targetRock == null || targetRock.health <= 0:
		isWorkerMining = false;
		attackTimer.stop();
		return;

	targetRock.takeDamage(1);


func moveToAttackRock(cell: Vector2i):
	if !tileMap.rocks.has(cell):
		return;

	targetRock = tileMap.rocks[cell];

	var fastestPath: PackedVector2Array;
	for neighbour in tileMap.get_surrounding_cells(cell):
		var path: PackedVector2Array = getPath(neighbour);
		if !path.is_empty() && (fastestPath.is_empty() || path.size() < fastestPath.size()):
			fastestPath = path;
		
	if fastestPath != null:
		moveWorker(fastestPath);


func moveWorker(path: PackedVector2Array):
	attackTimer.stop();
	pathToFollow = path;
	followTimer.start();


func getPath(target: Vector2i):
	return tileMap.astar_grid.get_point_path(tileMap.local_to_map(worker.position), target)
