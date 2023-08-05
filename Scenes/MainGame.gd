extends Control

var astar_grid = AStarGrid2D.new()
@onready var tileMap: TileMap = get_node("TileMap");
@onready var worker: Node2D = get_node("Worker");

var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	var usedTiles = tileMap.get_used_rect();
	astar_grid.region = Rect2i(0, 0, usedTiles.size.x, usedTiles.size.y);
	astar_grid.cell_size = tileMap.tile_set.tile_size;
	astar_grid.offset = tileMap.transform.get_origin() + astar_grid.cell_size/2;
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES;
	astar_grid.update();
	
	var rocks = tileMap.get_used_cells(2);
	for rock in rocks:
		astar_grid.set_point_solid(rock);
	
	pathToFollow = astar_grid.get_point_path(Vector2i(2, 4), Vector2i(11, 8));
	followTimer.connect("timeout", followTime);
	followTimer.wait_time = 0.5;
	add_child(followTimer);
	followTimer.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func followTime():
	if pathToFollow.is_empty():
		followTimer.stop();
		return
		
	worker.position = pathToFollow[0];
	pathToFollow.remove_at(0);
