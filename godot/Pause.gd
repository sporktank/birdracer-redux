extends Node


func _process(delta):
    if Input.is_action_just_pressed("pause"):
        get_tree().paused = not get_tree().paused
        $ColorRect.visible = get_tree().paused
