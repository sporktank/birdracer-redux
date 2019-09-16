extends Node2D


const SPEED = 250.0
const DAMAGE_SPEED = 0.3

var hitting = false
var taking_damage = 0.0

func _ready():
    $Area2D/AnimatedSprite.play() 


func _process(delta):
    
    var dir = 0
    if Input.is_action_pressed('up'):
        dir -= 1
    if Input.is_action_pressed('down'):
        dir += 1
    
    self.position.y += dir * SPEED * delta
    if self.position.y < 40:
        self.position.y = 40
    if self.position.y > 560:
        self.position.y = 560
    
    if self.hitting and self.taking_damage == 0.0:
        self.taking_damage = 1.0
        
    self.taking_damage -= DAMAGE_SPEED * delta
    if self.taking_damage < 0.0:
        self.taking_damage = 0.0
        
    if int(self.taking_damage * 16) % 2 == 1:
        self.visible = false
    else:
        self.visible = true

func _on_Area2D_area_entered(area):
    self.hitting = true


func _on_Area2D_area_exited(area):
    self.hitting = false
