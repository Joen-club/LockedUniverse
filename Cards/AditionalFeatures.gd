extends FeatureTool

export var card_type: PoolStringArray #Damage, Buff, Debuff
#export var indicators: PoolStringArray #Melee, Range

export var extended_area: Array #Up: 9, Down: 4, Left:2, Right:5, D_Right_Up: 8, D_Left_Down: 3,
#D_Left_Up: 7, D_Right_Down:: 6. D stands for "Diagonal

#Only for the "Exhaust" feature. I needed this to determine whether a card been played or not
var exhausted: bool 
