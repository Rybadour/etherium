extends Node2D
class_name Worker

const BASE_MOVE_SPEED = 50;

@onready var walkAnim: AnimationPlayer = get_node("Sprite2d/AnimationPlayer");
@onready var miningAnim: AnimationPlayer = get_node("Pickaxe/AnimationPlayer");

var mainGame: MainGame;
var gearSlots: GearSlots;
var pathToFollow: PackedVector2Array;
var attackTimer = Timer.new();
var isWorkerMining: bool = false;
var targetRock: Vector2i;

func _ready():
	attackTimer.connect("timeout", attackTime);
	add_child(attackTimer);


func setup(mainGame: MainGame):
	self.mainGame = mainGame;
	self.gearSlots = mainGame.inventory.gearSlots;


func startMiningAnimation():
	miningAnim.play("Mining");
	miningAnim.speed_scale = getAttackSpeed();


func moveTime():
	if pathToFollow.is_empty():
		isWorkerMining = true;
		attackTimer.wait_time = 1 / getAttackSpeed();
		attackTimer.start();
		walkAnim.stop();
		startMiningAnimation();
		return;
	
	var tween = get_tree().create_tween();
	var distance = position.distance_to(pathToFollow[0]);
	tween.tween_property(self, "position", pathToFollow[0], distance / getMovementSpeed());
	tween.tween_callback(moveTime);
	pathToFollow.remove_at(0);


func attackTime():
	var isDead = mainGame.workerAttacksRock(targetRock, getMiningDamage());
	if isDead:
		isWorkerMining = false;
		attackTimer.stop();
		miningAnim.stop();


func moveToAttackRock(cell: Vector2i):
	var fastestPath = mainGame.getFastestPath(cell);
	if fastestPath == null:
		return;
	
	targetRock = cell;
	walkAnim.play("Walk");
	walkAnim.speed_scale = getMovementSpeed() / BASE_MOVE_SPEED;
	moveWorker(fastestPath);


func moveWorker(path: PackedVector2Array):
	attackTimer.stop();
	pathToFollow = path;
	if pathToFollow[0].is_equal_approx(position):
		pathToFollow.remove_at(0);
	moveTime();


func getMiningDamage():
	return getStatWithMulti(Globals.StatType.MiningPower, Globals.StatType.IncreasedMiningPower);


func getAttackSpeed():
	return getStatWithMulti(Globals.StatType.ActionSpeed, Globals.StatType.IncreasedActionSpeed);


func getMovementSpeed():
	return getValueWithMulti(BASE_MOVE_SPEED, Globals.StatType.MovementSpeed);


func getStatWithMulti(flatStat: Globals.StatType, multiStat: Globals.StatType):
	var base: float = gearSlots.getStat(flatStat);
	return getValueWithMulti(base, multiStat);

func getValueWithMulti(value: float, multiStat: Globals.StatType):
	return value * (1 + gearSlots.getStat(multiStat)/100.0);
