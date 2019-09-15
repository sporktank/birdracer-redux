extends Sprite


const SPEED = 75.0


func _ready():
	pass 


func _process(delta):
	self.position.x -= SPEED * delta
	if self.position.x < 0:
		self.position.x += 1024.0
