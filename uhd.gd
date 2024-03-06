extends CanvasLayer

signal start_game;

func _ready():
	$StartButton.pressed.connect(on_start_button);
	$MessageTimer.timeout.connect(on_message_timer);

func show_message(text : String):
	$Message.text = text;
	$Message.show();
	$MessageTimer.start();

func show_game_over():
	show_message("Game Over");
	await $MessageTimer.timeout;
	
	$Message.text = "Dodge the Creeps!";
	$Message.show();
	
	await get_tree().create_timer(1.0).timeout;
	$StartButton.show();
	
func update_score(score : int):
	$ScoreLabel.text = str(score);
	
func on_start_button():
	$StartButton.hide();
	start_game.emit();
	
func on_message_timer():
	$Message.hide();
