extends Node

#Keys in the dictionary are being used in cards property "Additional_features" if you
#with to assign them some relationships with relics. Keys should be named exactly the same 
#as the relics.tscn's in the folder "Relics)
var relic_and_effects: Dictionary = {
	"more_damage": false,
	"RelicDisruptor": false,
	"DrawCard": false,
	"DebuffBonus": false,
	
}

"""Import Packed scenes in the Array again?"""
export var relic_references: Array = []
#Gonna make other arrays for rare relics and epic ones. Also functions for randomization
#Like in CardManager

signal relic_gained(name_of_relic)

