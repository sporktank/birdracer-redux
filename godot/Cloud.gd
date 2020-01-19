extends Node2D


const SPEED = 150.0


#func _ready():
#    add_to_group("obstacles")
#    #self.position.x = 1024 + 41 + randf()*200
#    #self.position.y = 60 + randf()*240
func _ready():
    self.scale = Vector2(0.8, 0.8)


func _process(delta):
    self.position.x -= get_parent().get_parent().tempo * SPEED * delta
    if self.position.x < -101:
        get_parent().get_parent().change_score(10)  # This is hacky, learn better way.
        queue_free()
        