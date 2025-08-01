extends Control
class_name MainGame

@onready var tileMap: Level = get_node("%TileMap");
@onready var resources: GlobalResources = get_node("CanvasLayer/Resources");
@onready var workers: Array[Worker] = [];

func _ready():
	#worker.setup(self);
	#tileMap.connect('cellClicked', worker.moveToAttackRock);
	return;


func workerAttacksRock(targetRock: Vector2i, damage: int):
	var isDead = tileMap.hurtRock(targetRock, damage);
	if isDead:
		resources.addResource(Globals.ResourceType.Copper, 5);
	
	return isDead;


#func getPath(target: Vector2i):
	#return tileMap.astar_grid.get_point_path(tileMap.local_to_map(worker.position), target)


#func getFastestPath(target: Vector2i):
	#if !tileMap.rocks.has(target):
		#return;
#
	#var fastestPath: PackedVector2Array;
	#for neighbour in tileMap.get_surrounding_cells(target):
		#var path: PackedVector2Array = getPath(neighbour);
		#if !path.is_empty() && (fastestPath.is_empty() || path.size() < fastestPath.size()):
			#fastestPath = path;
	#
	#return fastestPath;
