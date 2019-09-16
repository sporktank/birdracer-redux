extends Node2D


const SPEED = 150.0

var on_ground = false


func _ready():
    self.position.x = -100
    self.position.y = 300 


func _process(delta):
    self.position.x -= SPEED * delta
    if self.position.x < -41:
        self.position.x = 1024 + 41 + 200 + randf()*200
        self.position.y = 300
        self.on_ground = false
        
    if not self.on_ground:
        self.position.y += SPEED*4 * delta


func _on_Area2D_area_entered(area):
    self.on_ground = true
