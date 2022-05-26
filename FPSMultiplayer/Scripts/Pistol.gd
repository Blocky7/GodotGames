extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var equipped = false
var state = "none"
var damage = 5
var bullets = 10
var needbullets = 10
var ownray = false
onready var anim_player = $Pistol/AnimationPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

remote func equip():
	visible = true
	equipped = true
	pass

remote func unequip():
	visible = false
	equipped = false
	pass

func _physics_process(delta):
	if(equipped && get_parent().get_parent().get_parent().is_master):
		get_parent().get_parent().get_parent().get_parent().get_node("CanvasLayer/Bullets").text = str(bullets) + "/" + str(needbullets)
		if(Input.is_action_just_pressed("reload") && bullets < needbullets && get_parent().get_parent().get_parent().is_master):
			play_anim("reload")
			rpc("play_anim","reload")

remote func shoot():
	play_anim("shoot")
	$Pistol/ShootSound.play()
	pass

remote func play_anim(anim):
	if(state == anim):
		pass
	anim_player.play(anim)
	if(anim == "shoot"):
		bullets -= 1
	if(anim == "reload"):
		bullets = 10
	state = anim

