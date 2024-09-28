extends Node

# warning-ignore:unused_signal
signal change_state(new_state)
# warning-ignore:unused_signal
signal card(card)
signal currency_update
# warning-ignore:unused_signal
signal map_toggled

var currency: int= 1000 setget set_currency

func set_currency(value):
	currency = value
	emit_signal("currency_update", currency)
