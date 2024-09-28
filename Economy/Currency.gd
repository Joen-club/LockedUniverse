extends Control

onready var counter: Label = $Label

func _ready():
# warning-ignore:return_value_discarded
	GameManager.connect("currency_update", self, "update_counter")
	GameManager.currency = GameManager.currency

func update_counter(currency: int):
	counter.text = str(currency)
