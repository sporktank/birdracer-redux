extends Node2D


const SPEED = 150.0

var on_ground = false


func _ready():
    add_to_group("obstacles")
    #self.position.x = 1024 + 41 + 200 + randf()*200
    self.position.y = 300
    self.on_ground = false


func _process(delta):
    self.position.x -= get_parent().get_parent().tempo * SPEED * delta
    if self.position.x < -41:
        get_parent().get_parent().change_score(10)  # This is hacky, learn better way.
        queue_free()
        
    if not self.on_ground and self.position.x < 1024.0*1.5:
        self.position.y += SPEED*4 * delta


func _on_Area2D_area_entered(area):
    self.on_ground = true
