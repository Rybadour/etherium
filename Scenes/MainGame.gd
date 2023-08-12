extends Control

@onready var tileMap: Rocks = get_node("TileMap");
@onready var resources: GlobalResources = get_node("CanvasLayer/Resources");
@onready var worker: Worker = get_node("TileMap/Worker");
@onready var inventory: InventoryPanel = get_node("CanvasLayer/InventoryPanel");
var lootGen: LootGeneration = LootGeneration.new();

var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;
var attackTimer = Timer.new();
var isWorkerMining: bool = false;
var targetRock: Vector2i;

# Called when the node enters the scene tree for the first time.
func _ready():
	followTimer.connect("timeout", followTime);
	followTimer.wait_time = 0.5;
	add_child(followTimer);

	attackTimer.connect("timeout", attackTime);
	attackTimer.wait_time = 1;
	add_child(attackTimer);

	tileMap.connect('cellClicked', moveToAttackRock);
	
	for i in 5:
		inventory.addItem(lootGen.generateLootFromRock());


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func followTime():
	if pathToFollow.is_empty():
		followTimer.stop();
		isWorkerMining = true;
		attackTimer.start();
		worker.startMiningAnimation();
		return
		
	worker.position = pathToFollow[0];
	pathToFollow.remove_at(0);


func attackTime():
	var isDead = tileMap.hurtRock(targetRock, 4);
	if isDead:
		isWorkerMining = false;
		attackTimer.stop();
		worker.stopMiningAnimation();
		resources.addResource(GlobalResources.ResourceType.COPPER, 5);
		inventory.addItem(lootGen.generateLootFromRock());
		return;


func moveToAttackRock(cell: Vector2i):
	if !tileMap.rocks.has(cell):
		return;

	targetRock = cell;

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
