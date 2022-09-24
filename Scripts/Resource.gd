extends Panel

@export var amount: int;

# Called when the node enters the scene tree for the first time.
func setAmount(a: int):
	amount = a;
	var label: Label = $HBoxContainer/AmountLabel;
	label.text = Utils.comma_sep(a);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
