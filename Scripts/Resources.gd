extends Control
class_name GlobalResources

var resourceComp = preload("res://Components/Resource.tscn");

enum ResourceType {MONEY, COPPER}

var resources: Dictionary = {
	ResourceType.MONEY: 0,
	ResourceType.COPPER: 0,
}
var resourceIds: Dictionary = {
	ResourceType.MONEY: "Money",
	ResourceType.COPPER: "Copper",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for r in resources:
		var resource = get_node("VBoxContainer/" + resourceIds[r]);
		if resource != null:
			resource.setAmount(resources[r]);
			resource.set_visible(true);


func addResource(res: ResourceType, amount: float):
	if !resources.has(res):
		return;

	resources[res] += amount;
	var resource = get_node("VBoxContainer/" + resourceIds[res]);
	resource.setAmount(resources[res]);
