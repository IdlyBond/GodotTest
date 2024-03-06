extends Node

@export var mob_scene: PackedScene;
var score : int;

func _ready():
	print_tree_pretty();
	$Player.hit.connect(on_player_hit);
	$ScoreTimer.timeout.connect(on_score_timer);
	$StartTimer.timeout.connect(on_start_timer_timeout);
	$MobTimer.timeout.connect(on_mob_timer_timeout);
	new_game();

func game_over():
	$ScoreTimer.stop();
	$MobTimer.stop();
	
func new_game():
	score = 0;
	$Player.start($StartPosition.position);
	$StartTimer.start();

func on_start_timer_timeout():
	$MobTimer.start();
	$ScoreTimer.start();

func on_player_hit():
	game_over();
	
func on_score_timer():
	score += 1;
	
func on_mob_timer_timeout():
	var mob = mob_scene.instantiate();
	
	var mob_spawn_location = $MobPath/MobSpawnLocation;
	mob_spawn_location.progress_ratio = randf();
	
	var direction = mob_spawn_location.rotation - PI / 2;
	
	mob.position = mob_spawn_location.position;
	
	direction += randf_range(-PI / 4, PI / 4);
	mob.rotation = direction;
	
	var speed = randf_range(150.0, 250.0);
	var velocity = Vector2.from_angle(direction).normalized() * speed;	
	mob.linear_velocity = velocity;
	
	add_child(mob);

