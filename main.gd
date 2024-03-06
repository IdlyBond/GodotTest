extends Node

@export var mob_scene: PackedScene;
var score : int;

func _ready():
	$UHD.update_score(0);
	$Player.hit.connect(on_player_hit);
	$ScoreTimer.timeout.connect(on_score_timer);
	$StartTimer.timeout.connect(on_start_timer_timeout);
	$MobTimer.timeout.connect(on_mob_timer_timeout);
	$UHD/StartButton.pressed.connect(new_game);
	$UHD.show_message("Dodge the Creeps!");

func game_over():
	get_tree().call_group("mobs", "queue_free");
	$UHD.show_game_over();
	$ScoreTimer.stop();
	$MobTimer.stop();
	$Music.stop();
	$DeathSound.play();
	
func new_game():
	score = 0;
	$UHD.update_score(score);
	$UHD.show_message("Get Ready...");
	$UHD/StartButton.hide();
	$Player.start($StartPosition.position);
	$StartTimer.start();
	if not $Music.playing:
		$Music.play();

func on_start_timer_timeout():
	$MobTimer.start();
	$ScoreTimer.start();

func on_player_hit():
	game_over();
	
func on_score_timer():
	score += 1;
	$UHD.update_score(score);
	
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

