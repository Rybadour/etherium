extends Node2D
class_name Worker

@onready var miningAnim: AnimationPlayer = get_node("Pickaxe/AnimationPlayer");

var mainGame: MainGame;
var gearSlots: GearSlots;
var followTimer = Timer.new();
var pathToFollow: PackedVector2Array;
var attackTimer = Timer.new();
var isWorkerMining: bool = false;
var targetRock: Vector2i;

func _ready():
	followTimer.connect("timeout", followTime);
	followTimer.wait_time = 0.5;
	add_child(followTimer);

	attackTimer.connect("timeout", attackTime);
	add_child(attackTimer);


func setup(mainGame: MainGame):
	self.mainGame = mainGame;
	self.gearSlots = mainGame.inventory.gearSlots;


func startMiningAnimation():
	miningAnim.play("Mining");
	miningAnim.speed_scale = getAttackSpeed();


func stopMiningAnimation():
	miningAnim.stop();


func followTime():
	if pathToFollow.is_empty():
		followTimer.stop();
		isWorkerMining = true;
		attackTimer.wait_time = 1 / getAttackSpeed();
		attackTimer.start();
		startMiningAnimation();
		return
		
	position = pathToFollow[0];
	pathToFollow.remove_at(0);


func attackTime():
	var isDead = mainGame.workerAttacksRock(targetRock, getMiningDamage());
	if isDead:
		isWorkerMining = false;
		attackTimer.stop();
		stopMiningAnimation();


func moveToAttackRock(cell: Vector2i):
	var fastestPath = mainGame.getFastestPath(cell);
	if fastestPath == null:
		return;
	
	targetRock = cell;
	moveWorker(fastestPath);


func moveWorker(path: PackedVector2Array):
	attackTimer.stop();
	pathToFollow = path;
	followTimer.start();


func getMiningDamage():
	return getStatWithMulti(Globals.StatType.MiningPower, Globals.StatType.IncreasedMiningPower);


func getAttackSpeed():
	return getStatWithMulti(Globals.StatType.ActionSpeed, Globals.StatType.IncreasedActionSpeed);


func getStatWithMulti(flatStat: Globals.StatType, multiStat: Globals.StatType):
	var base: float = gearSlots.getStat(flatStat);
	return base * (1 + gearSlots.getStat(multiStat)/100.0);
