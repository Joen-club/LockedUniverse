extends EnemyState

var disabled_point: Vector2

func init(new_owner: Entity):
	.init(new_owner)
	my_owner.connect("died", self, "enable_points")
	call_deferred("disable_points")

func moving_here(destination):
	my_owner.grid.enable_points(disabled_point)
	yield(.moving_here(destination), "completed")
	call_deferred("disable_points")

func disable_points():
	my_owner.grid.disable_points(my_owner.my_position)
	disabled_point = my_owner.my_position

func enable_points(_died_owner: Entity):
	my_owner.grid.enable_points(my_owner.my_position)
	my_owner.player.highlight.highlight()

func attack():
	pass
