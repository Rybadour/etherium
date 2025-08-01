extends Node2D
class_name Worker

const BASE_MOVE_SPEED = 50;

@onready var walkAnim: AnimationPlayer = get_node("Sprite2d/AnimationPlayer");
@onready var miningAnim: AnimationPlayer = get_node("Pickaxe/AnimationPlayer");

var level: int = 1;

var mainGame: MainGame;
var pathToFollow: PackedVector2Array;
var attackTimer = Timer.new();
var isWorkerMining: bool = false;
var targetRock: Vector2i;


func _ready():
	attackTimer.connect("timeout", attackTime);
	add_child(attackTimer);


func setup(mainGame: MainGame):
	self.mainGame = mainGame;


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
		
	attackTimer.stop();
	miningAnim.stop();
	
	targetRock = cell;
	walkAnim.play("Walk");
	walkAnim.speed_scale = getMovementSpeed() / BASE_MOVE_SPEED;
	moveWorker(fastestPath);


func moveWorker(path: PackedVector2Array):
	if path.size() <= 0:
		return;
	
	attackTimer.stop();
	pathToFollow = path;
	if pathToFollow[0].is_equal_approx(position):
		pathToFollow.remove_at(0);
	moveTime();


func getMiningDamage():
	return 1 * level;


func getAttackSpeed():
	return 1 + log(0.1 * level);


func getMovementSpeed():
	return BASE_MOVE_SPEED + log(10 * level);
