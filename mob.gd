extends RigidBody2D


func _ready():
	var mob_types = $Animator.sprite_frames.get_animation_names();
	$Animator.play(mob_types[randi() % mob_types.size()]);
	$VisibleOnScreenNotifier2D.screen_exited.connect(on_screen_exited);

func on_screen_exited():
	queue_free();
