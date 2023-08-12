extends Panel
class_name GearSlots

signal returnItem(item: RealItem);

@onready var slots: Dictionary = { #SlotType -> GearSlot
	Globals.SlotType.Head: get_node("Head"),
	Globals.SlotType.Weapon: get_node("Weapon"),
	Globals.SlotType.Chest: get_node("Chest"),
	Globals.SlotType.Amulet: get_node("Amulet"),
	Globals.SlotType.Gloves: get_node("Gloves"),
	Globals.SlotType.Ring: get_node("Ring"),
	Globals.SlotType.Boots: get_node("Boots"),
};

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func assignGear(item: RealItem):
	var slot = slots[item.item.slotType];
	if slot == null:
		return;
		
	slot.setItem(item);
	slot.itemTile.connect("transferRequest", Callable(self, "returnItemRequest").bind(item));


func removeGear(slotType: Globals.SlotType):
	var slot = slots[slotType];
	if slot == null:
		return false;
	
	return slot.removeItem();


func isSlotFilled(slotType: Globals.SlotType):
	var slot = slots[slotType];
	if slot == null:
		return false;
	
	return slot.item != null;


func returnItemRequest(item: RealItem):
	returnItem.emit(removeGear(item.item.slotType));
