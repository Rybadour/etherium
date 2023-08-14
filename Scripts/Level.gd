extends TileMap
class_name Level

signal cellClicked(cell: Vector2i)

const FLOOR_LAYER = 0;
const ROCKS_LAYER = 2;

@onready var rockUIContainer: Node2D = get_node("%RockUIContainer");
var rockScene = preload("res://Components/Rock.tscn")

var astar_grid = AStarGrid2D.new();
var rocks: Dictionary; #Vector2i -> Rock
var rockTypes: Array[RockTile];
var chestTiles: Array[ChestTile];
var oreStringToTypeMap: Dictionary = {
	"Coal": Globals.OreType.Coal,
	"Copper": Globals.OreType.Copper,
	"Iron": Globals.OreType.Iron,
	"Silver": Globals.OreType.Silver,
	"Gold": Globals.OreType.Gold,
}

func _ready():
	generateRockTypes();
	var usedTiles = self.get_used_rect();
	
	astar_grid.region = Rect2i(0, 0, usedTiles.size.x, usedTiles.size.y);
	astar_grid.cell_size = self.tile_set.tile_size;
	astar_grid.offset = astar_grid.cell_size/2;
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES;
	astar_grid.update();
	
	generateRocks();

	var wallCells = self.get_used_cells(1);
	for cell in wallCells:
		astar_grid.set_point_solid(cell);


func generateRockTypes():
	for sourceId in self.tile_set.get_source_count():
		var source: TileSetAtlasSource = self.tile_set.get_source(sourceId);
		for t in source.get_tiles_count():
			var tileId: Vector2i = source.get_tile_id(t);
			var tileData: TileData = source.get_tile_data(tileId, 0);
			var oreType: String = tileData.get_custom_data("OreType");
			if oreType == "":
				continue;

			if oreType == "Chest":
				chestTiles.append(ChestTile.new(sourceId, tileId));
			else:
				rockTypes.append(RockTile.new(
					sourceId,
					tileId,
					oreStringToTypeMap[oreType],
					tileData.get_custom_data("Yield"),
					tileData.get_custom_data("Strength"),
				));


func getRockByStrength(strength: float):
	var stri = floor(strength);
	var possibleRocks: Array[RockTile];
	for rock in rockTypes:
		if rock.strength == stri:
			possibleRocks.append(rock);
	
	if possibleRocks.size() > 0:
		return possibleRocks[randi_range(0, possibleRocks.size() - 1)];


func generateRocks():
	var noise = FastNoiseLite.new()

	noise.noise_type = FastNoiseLite.NoiseType.TYPE_PERLIN;
	noise.seed = randi();
	noise.fractal_octaves = 4;
	noise.frequency = 1.0 / 5.0;

	var floorCells = self.get_used_cells(FLOOR_LAYER);
	const minThreshold = 0.1;
	for cell in floorCells:
		var cellNoise = noise.get_noise_2d(cell.x, cell.y);
		if cellNoise > minThreshold:
			if cellNoise > 0.4:
				createChest(cell);
			else:
				createRock(cell, getRockByStrength((cellNoise-minThreshold) * 15));


func createRock(cell: Vector2i, rockTile: RockTile):
	if rockTile == null:
		return;
		
	self.set_cell(ROCKS_LAYER, cell, rockTile.tileSourceId, rockTile.tileId);
	var rockUI: Rock = rockScene.instantiate();
	rockUI.setup((rockTile.strength + 1) * 20, rockTile.ore, rockTile.oreYield);
	rockUI.position = self.map_to_local(cell);
	rocks[cell] = rockUI;
	rockUIContainer.add_child(rockUI);

	astar_grid.set_point_solid(cell);


func createChest(cell: Vector2i):
	var chest = chestTiles[randi_range(0, chestTiles.size()-1)];

	self.set_cell(ROCKS_LAYER, cell, chest.tileSourceId, chest.tileId);
	astar_grid.set_point_solid(cell);

func _unhandled_input(event):
	if event.is_action_released("primary_select"):
		cellClicked.emit(self.local_to_map(self.get_local_mouse_position()));

	
func hurtRock(rockCell: Vector2i, damage: int) -> bool:
	if !rocks.has(rockCell):
		return true;

	var rock = rocks[rockCell];
	rock.takeDamage(damage);
	if rock.health <= 0:
		rockUIContainer.remove_child(rock);
		self.set_cell(ROCKS_LAYER, rockCell);
		rocks.erase(rockCell);
		astar_grid.set_point_solid(rockCell, false);
		return true;
	
	return false;
