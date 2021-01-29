extends Node2D
export var block_scene:PackedScene;
onready var breakingSound:AudioStreamPlayer = $"/root/main/LevelSFX/WallBreak";
onready var breakingSound2:AudioStreamPlayer = $"/root/main/LevelSFX/CliffBreaking";
onready var level = $"/root/main/Level"
onready var hitBox = $"Body/HitBox"
var min_speed = 270;
func spawnBlock(pos:Vector2, speed:Vector2, body):
	var block:Node2D = block_scene.instance();
	block.speed = speed;
	block.position = global_position + pos;
	block.spawnpoint = block.position
	level.add_child(block);

func _on_BreakArea_body_entered(body):
	if body.is_class("PlayerPhysics"):
		var player:PlayerPhysics = body
		if player.is_grounded:
			if player.is_rolling:
				if abs(player.gsp) > min_speed:
					breakingSound.play()
					breakingSound2.play()
					var speed:Vector2
					speed = player.velocity
					for i in range(0, 3):
						for j in 2:
							speed.x += j * 20
							speed.y += (i+1) * 20
							spawnBlock(\
								Vector2([-8, 8][j], [-22, 0, 22][i]),\
								speed,\
								player
							)
					queue_free()
					

