extends Node2D

# Code for embedding in Google Sites:
# <iframe width="1024" height="600" src="https://sporktank.github.io/brr-0-2/brr-0-2.html">

var cloud = preload("res://Cloud.tscn")
var tree = preload("res://Tree.tscn")

var score
var lives
var tempo
var highscore = 0

const WAVES = """
1000
0000
0100
0000
0010
0000
0001
0000
1001
0000
0110
0000
0000
1000
0100
0010
0000
0001
0010
0100
0000
0000
1110
0000
1011
0000
1101
0000
0111
0000
0000
0100
0001
0010
1000
1100
1001
0000
0010
1000
0100
0000
1001
1001
1001
0000
0110
0110
0110
0110
0000
0000
1110
0000
0111
0000
1110
0000
0111
0000
0000
1000
0010
0100
0001
0000
0111
0111
0111
0111
0000
0010
0100
0000
1001
1001
1101
1001
1001
0000
0111
0011
1001
1100
1110
1100
1001
0011
0111
0011
1001
1100
1110
1100
1001
0011
0111
0000
0000
0000
0100
0001
0010
1000
1100
1001
0000
0010
1000
0100
0000
0000
0000
0000
0000
0000
0000
1111
"""


func restart():
	for child in $Obstacles.get_children():
		$Obstacles.remove_child(child)
		child.queue_free()
	score = 0.0
	lives = 9
	tempo = 1.25
	$GameOver/ColorRect.visible = false
	$Bird.position = Vector2(150, 300)
	setup_waves()


func change_score(delta):
	if lives > 0:
		score += delta
		if score > highscore:
			highscore = score


func bird_hit():
	lives -= 1
	if lives <= 0:
		$GameOver/ColorRect.visible = true
		$Bird.position.x = -150

	
func setup_waves():
	var xoff = 1024.0 + 200.0
	for wave in WAVES.split('\n'):
		
		var idx = 0
		for flag in wave:
			if int(flag) == 1:
				var obj
				if idx == 0:
					obj = tree.instance()
				else:
					obj = cloud.instance()
					obj.position.y = 96.0 + (3-idx)*96.0
				
				obj.position.x = xoff + (randf()*0.0 - 0.0)
				$Obstacles.add_child(obj)
			
			idx += 1
		
		xoff += 192.0


func _ready():
    restart()

	
func _process(delta):
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()

	if Input.is_action_pressed("restart"):
		restart()

	change_score(delta)
	$Score.text = " Score: %d" % int(score)
	$HighScore.text = "HiScore: %d " % int(highscore)
	
	$LivesGroup/Life1.modulate = Color(1, 1, 1, 0.15 if lives < 9 else 1.0)
	$LivesGroup/Life2.modulate = Color(1, 1, 1, 0.15 if lives < 8 else 1.0)
	$LivesGroup/Life3.modulate = Color(1, 1, 1, 0.15 if lives < 7 else 1.0)
	$LivesGroup/Life4.modulate = Color(1, 1, 1, 0.15 if lives < 6 else 1.0)
	$LivesGroup/Life5.modulate = Color(1, 1, 1, 0.15 if lives < 5 else 1.0)
	$LivesGroup/Life6.modulate = Color(1, 1, 1, 0.15 if lives < 4 else 1.0)
	$LivesGroup/Life7.modulate = Color(1, 1, 1, 0.15 if lives < 3 else 1.0)
	$LivesGroup/Life8.modulate = Color(1, 1, 1, 0.15 if lives < 2 else 1.0)
	$LivesGroup/Life9.modulate = Color(1, 1, 1, 0.15 if lives < 1 else 1.0)
	
	if lives in [9, 8, 3]:
		$Bird/Area2D/RedPlane.visible = true
		$Bird/Area2D/GreenPlane.visible = false
		$Bird/Area2D/BluePlane.visible = false
		$Bird.flight_mode = 'red'
	if lives in [7, 6, 2]:
		$Bird/Area2D/RedPlane.visible = false
		$Bird/Area2D/GreenPlane.visible = true
		$Bird/Area2D/BluePlane.visible = false
		$Bird.flight_mode = 'green'
	if lives in [5, 4, 1]:
		$Bird/Area2D/RedPlane.visible = false
		$Bird/Area2D/GreenPlane.visible = false
		$Bird/Area2D/BluePlane.visible = true
		$Bird.flight_mode = 'blue'
        
	if $Obstacles.get_child_count() == 0:
		setup_waves()
		tempo += 0.1        