extends Label

var numCoins = 0

func _ready():
	text = String(numCoins)

func _on_coin_collected():
	numCoins = numCoins + 1
	text = String(numCoins)
