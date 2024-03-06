extends Sprite2D

var speed = 600;
var angular_speed = PI;
var is_motion = true;
signal onToggledVisibility;

func _init():
	print("Hello Worlds!");

func _ready():
	var timer = get_node("VisibilityTimer");
	timer.timeout.connect(on_timer_timeout);
	
func on_timer_timeout():
	print("Timer stop");
	visible = !visible;
	onToggledVisibility.emit();
	
func _process(delta):
	if !is_motion:
		return;
	var direction = 0;
	if Input.is_action_pressed("ui_left"):
		direction = -1;
	if Input.is_action_pressed("ui_right"):
		direction = 1;
	rotation += angular_speed * direction * delta;
	
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed;
		
	position += velocity * delta


func _on_toggle_motion_pressed():
	is_motion = !is_motion;
