extends Node

class_name FeatureTool

#Some cards have specific features (one-time use per battle, inverse the active cells and so on)
export var features: Dictionary
#Those are the descriptions of each feature for the Description Node
export var feature_description: Dictionary

##If the card has features that are enabled, then at the beginning this function
##Gives an info to the "Parameters" Node about what features are being used and
##Their descriptions.
func describe_new(parameters: Node):
	for i in features:
		if features[i]:
			parameters.params["["+i+"]"] = i #In the editor of a "Description" Node
			#I use key words in brackets. This parameter helps remove brackets in the game
			parameters.feature_params["["+i+"]"] = feature_description[i] #This one is used in the
			#"Description" node to show a panel with a description of a key word. 
