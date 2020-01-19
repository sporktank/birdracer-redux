extends Node2D


const SPEED = 250.0
const ACCEL = 1000.0
const ROTATE_SPEED = 1.1
const DAMAGE_SPEED = 0.3

var hitting = false
var taking_damage = 0.0
var flight_mode = 'red'
var y_vel = 0.0


func _ready():
    $Area2D/RedPlane.play() 
    $Area2D/GreenPlane.play() 
    $Area2D/BluePlane.play() 


func _process(delta):
    
    var dir = 0
    if Input.is_action_pressed('up'):
        dir -= 1
    if Input.is_action_pressed('down'):
        dir += 1

    var tap = 0
    if Input.is_action_just_pressed('up'):
        tap = 1
		
    if self.flight_mode == 'red':
        self.position.y += dir * SPEED*1.1 * delta
        self.rotation = 0.0

    if self.flight_mode == 'green':
        self.rotation += dir * ROTATE_SPEED * delta
        if self.rotation < -0.8: self.rotation = -0.8
        if self.rotation >  0.8: self.rotation =  0.8
        self.position.y += sin(self.rotation) * SPEED*1.3 * delta

    if self.flight_mode == 'blue':
        y_vel += ACCEL * delta
        if y_vel > 500.0: y_vel = 500.0
        if tap:
            if y_vel > 0:
                y_vel = -150.0
            else:
                y_vel = -300.0
        self.position.y += y_vel * delta
        self.rotation = 0.0
		
    if self.position.y < 40:
        self.position.y = 40
    if self.position.y > 560:
        self.position.y = 560
    
    if self.hitting and self.taking_damage == 0.0:
        self.taking_damage = 1.0
        get_parent().bird_hit()
        
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
