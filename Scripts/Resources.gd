extends Control
class_name GlobalResources

var resourceComp = preload("res://Components/Resource.tscn");

var resources: Dictionary = {
	Globals.ResourceType.MONEY: 0,
	Globals.ResourceType.COPPER: 0,
}
var resourceIds: Dictionary = {
	Globals.ResourceType.MONEY: "Money",
	Globals.ResourceType.COPPER: "Copper",
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
