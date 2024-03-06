extends Area2D

signal hit;
@export var speed = 400;
var screen_size;

func _ready():
	screen_size = get_viewport_rect().size;
	hide();
	
func _process(delta):
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1;
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1;
	if velocity.x != 0:
		$Animation.animation = "walk";
		$Animation.flip_v = false;
		$Animation.flip_h = velocity.x < 0;
	elif velocity.y != 0:
		$Animation.animation = "up";
		$Animation.flip_v = velocity.y > 0;
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$Animation.play();
	else: 
		$Animation.stop();
	position += velocity * delta;
	position = position.clamp(Vector2.ZERO, screen_size);


func _on_body_entered(body):
	hide();
	hit.emit();
	$Collider.set_deferred("disabled", true);
	
func start(pos):
	position = pos;
	show();
	$Collider.disabled = false;
