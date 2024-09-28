extends Area2D

var my_owner: Entity
var positions: Array = [Vector2(32, 32), Vector2(96, 96),Vector2(96, 32), Vector2(32, 96), ]

func _ready():
	my_owner = get_parent()

func _on_NeighbourDetecter_body_entered(body: Entity):
	if body == my_owner: return
	var body_count: Array = get_overlapping_bodies()
	var count: int = 0
	for entity in body_count:
		entity.sprite.offset = positions[count]
		if count%2 == 1 and entity.health_bar != null:
			entity.health_bar.margin_bottom = 51
			entity.health_bar.margin_top = 51
		count += 1

func _on_NeighbourDetecter_body_exited(_body: Entity):
	var body_count: Array = get_overlapping_bodies()
	if body_count.size() == 1:
		if my_owner.health_bar != null: #Temporary
			my_owner.health_bar.margin_bottom = 2
			my_owner.health_bar.margin_top = 0
		my_owner.sprite.offset = Vector2(64, 64)
