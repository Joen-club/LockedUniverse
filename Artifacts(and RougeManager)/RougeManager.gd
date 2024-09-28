extends Node

func _ready():
	RelicManager.connect("relic_gained", self, "check_relics")

func load_relic(relic_owner, relic_path):
	var new_relic_pack = load(relic_path)
	var new_relic = new_relic_pack.instance()
	new_relic.my_owner = relic_owner
	relic_owner.add_child(new_relic)

func check_relics(relic_name: String):
	for relic_loader in get_tree().get_nodes_in_group("relic_loaders"):
		if relic_loader.relics_features.has(relic_name):
			load_relic(relic_loader.my_owner, "res://Artifacts(and RougeManager)/Relics/"+relic_name+".tscn")

func on_player_died(_player: Entity):
	print("ULTRA_LOX")
