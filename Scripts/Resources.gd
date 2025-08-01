extends Control
class_name GlobalResources

var resourceComp = preload("res://Components/Resource.tscn");

var resources: Dictionary = {
	Globals.ResourceType.Gold: 0,
	Globals.ResourceType.Copper: 0,
}
var resourceIds: Dictionary = {
	Globals.ResourceType.Gold: "Money",
	Globals.ResourceType.Copper: "Copper",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for r in resources:
		var resource = get_node("VBoxContainer/" + resourceIds[r]);
		if resource != null:
			resource.setAmount(resources[r]);
			resource.set_visible(true);


func addResource(res: Globals.ResourceType, amount: float):
	if !resources.has(res):
		return;

	resources[res] += amount;
	var resource = get_node("VBoxContainer/" + resourceIds[res]);
	resource.setAmount(resources[res]);
