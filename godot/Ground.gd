extends Node2D


const SPEED = 150.0


func _ready():
    pass 


func _process(delta):
    self.position.x -= get_node('..').tempo * SPEED * delta
    if self.position.x < -1616:
        self.position.x += 1616
