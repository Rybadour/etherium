extends Control
class_name Resources

var resourceComp = preload("res://Components/Resource.tscn");

var resources: Dictionary = {
	"Money": 123500,
	"Copper": 23,
	"Iron": 0,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in resources:
		var resource = get_node("VBoxContainer/" + i);
		if resource != null:
			resource.setAmount(resources[i]);
			resource.set_visible(true);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
