extends Control

@onready var tileMap: Rocks = get_node("TileMap");
@onready var worker: Node2D = get_node("Worker");

var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	pathToFollow = tileMap.astar_grid.get_point_path(Vector2i(2, 4), Vector2i(11, 8));
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
