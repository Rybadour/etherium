extends Panel

var isExpanded = false;
@onready var grid: GridContainer = find_child("GridContainer");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
