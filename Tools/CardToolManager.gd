extends FeatureTool

export var tool_instances: Dictionary #Unlike simple features: tools require separate scenes
export var chargeable_options: Dictionary #Tinker with that only if the chargeable 
#tool is turned on. 19.05.24: *** This must be removed and changed
var my_owner: Card

"""Chargeable как комплектация множества ф-ций - возможно, не самое лучшее 
решение, ибо пользователь не будет знать, что конкретно делает чардж"""

func load_tool(new_tool):
	var loaded_tool = new_tool.instance()
	loaded_tool.my_owner = my_owner
	my_owner.add_child(loaded_tool)
	if loaded_tool.name == "Chargeable": # *** Crude, used only for one tool
		for k in chargeable_options: #Maybe there's an option of optimizing
			if chargeable_options[k]:
				loaded_tool.define_feature(k)
	loaded_tool.init()

func define_owner(owner: Card):
	my_owner = owner
	for Tool in features:
		if features[Tool]:
			load_tool(tool_instances[Tool])

#func describe_new(parameters: Node): #Maybe should add this as well to describe
									#exhaust and chargeable, but not sure
#	pass
