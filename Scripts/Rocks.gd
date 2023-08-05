extends TileMap
class_name Rocks

@onready var rockUIContainer: Node2D = get_node("RockUIContainer");
var rockScene = preload("res://Components/RockUI.tscn")

var astar_grid = AStarGrid2D.new();
var rocks: Dictionary = {};

func _ready():
	var usedTiles = self.get_used_rect();
	
	astar_grid.region = Rect2i(0, 0, usedTiles.size.x, usedTiles.size.y);
	astar_grid.cell_size = self.tile_set.tile_size;
	astar_grid.offset = self.transform.get_origin() + astar_grid.cell_size/2;
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES;
	astar_grid.update();

	var rockCells = self.get_used_cells(2);
	for cell in rockCells:
		var rockUI: RockUI = rockScene.instantiate();
		rockUI.position = self.map_to_local(cell);
		rocks[cell] = rockUI;
		rockUIContainer.add_child(rockUI);

		rockUI.takeDamage(4);

		astar_grid.set_point_solid(cell);

	
func hurtRock(rockCell: Vector2i, damage: int):
	var rock = rocks[rockCell];
	if (rock != null):
		rock.takeDamage(damage);
