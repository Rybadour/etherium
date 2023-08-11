extends Panel
class_name InventoryPanel

var itemTile = preload('res://Components/ItemTile.tscn');

var isExpanded = false;
var items: Array[Item];
@onready var grid: GridContainer = find_child("GridContainer");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func expandToggle():
	if isExpanded:
		custom_minimum_size.x = 128;
		grid.columns = 1;
		isExpanded = false;
	else:
		custom_minimum_size.x = 328;
		grid.columns = 3;
		isExpanded = true;


func addItem(item: Item):
	items.append(item);
	var tile: ItemTile = itemTile.instantiate();
	tile.item = item;
	grid.add_child(tile);
