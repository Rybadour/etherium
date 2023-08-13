extends Control
class_name MainGame

@onready var tileMap: Level = get_node("%TileMap");
@onready var resources: GlobalResources = get_node("CanvasLayer/Resources");
@onready var worker: Worker = get_node("%TileMap/Worker");
@onready var inventory: InventoryPanel = get_node("CanvasLayer/InventoryPanel");
var lootGen: LootGeneration = LootGeneration.new();


func _ready():
	worker.setup(self);
	tileMap.connect('cellClicked', worker.moveToAttackRock);
	
	inventory.pickupItem(lootGen.generateItemWithStats(ItemConfig.weaponItems[0], lootGen.rarities[Globals.ItemRarity.Common]));
	#inventory.pickupItem(lootGen.generateItemWithStats(ItemConfig.bootsItems[0], lootGen.rarities[Globals.ItemRarity.Rare]));


func workerAttacksRock(targetRock: Vector2i, damage: int):
	var isDead = tileMap.hurtRock(targetRock, damage);
	if isDead:
		resources.addResource(Globals.ResourceType.COPPER, 5);
		inventory.pickupItem(lootGen.generateLootFromRock());
	
	return isDead;


func getPath(target: Vector2i):
	return tileMap.astar_grid.get_point_path(tileMap.local_to_map(worker.position), target)


func getFastestPath(target: Vector2i):
	if !tileMap.rocks.has(target):
		return;

	var fastestPath: PackedVector2Array;
	for neighbour in tileMap.get_surrounding_cells(target):
		var path: PackedVector2Array = getPath(neighbour);
		if !path.is_empty() && (fastestPath.is_empty() || path.size() < fastestPath.size()):
			fastestPath = path;
	
	return fastestPath;
