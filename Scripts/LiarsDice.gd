extends Node2D

export (String, FILE) var players = ""
export var numPlayers = 2

onready var player = $Player
onready var choices = $LiarsDiceChoices
onready var playerChoicesMenu = $LiarsDiceChoices/PlayerTurnChoices
onready var bluffCallChoices = $LiarsDiceChoices/BluffCallChoices
onready var choicesButton = $LiarsDiceChoices/PlayerTurnChoices/Button
onready var choicesNumDicePicker = $LiarsDiceChoices/VBoxContainer/Button/NumberOfDice
onready var choicesDiceNumPicker = $LiarsDiceChoices/VBoxContainer/Button/DieNumber
onready var callButton = $LiarsDiceChoices/BluffCallChoices/CALL
onready var passButton = $LiarsDiceChoices/BluffCallChoices/PASS
onready var playerLabel = $PlayerHand
onready var opponentLabel = $OpponentHand
onready var textbox = $Textbox

var numDiceEach = []
var playerHand = []
var opponentHand = []
#onready var xLoc = player.position.x
#onready var yLoc = player.position.y
var turn = turnOrder.NOPLAYER
var playerRound = 1
var numDiceBet = 0
var diceNumBet = 0
var roundDone = false
var curr_npc = 0

var endRound = false
var npcHasBet = false
var wasRight = false

enum turnOrder {
	NOPLAYER
	PLAYER,
	NOTPLAYER,
	GAMEOVER
}

func _ready():
	textbox.hide_textbox()
	choicesButton.connect("submitted", self, "my_turn_over")
	callButton.connect("called", self, "player_called")
	passButton.connect("passed", self, "player_passed")
	for i in range(numPlayers):
		numDiceEach.insert(i, 5)
		
func wrap_up_round():
	var totalOfBet = 0
	#for i in range(numPlayers):
#	var onePlayerHand = playerHands[i]
#	totalOfBet += onePlayerHand[diceNumBet - 1] 
	totalOfBet = playerHand[diceNumBet - 1] + opponentHand[diceNumBet - 1]
	if numDiceBet <= totalOfBet:
		print(str(turn) + " was right")
		wasRight = true
	round_done()
			
func round_done():
	if (wasRight and turn == turnOrder.PLAYER) || (!wasRight && turn == turnOrder.NOTPLAYER):
		playerLabel.text = "you win"
		opponentLabel.text = "you lose"
		textbox.queue_text("you win!")
	else:
		playerLabel.text = "you lose"
		opponentLabel.text = "you win"
		textbox.queue_text("you lose...")
	turn = turnOrder.GAMEOVER
		
func _process(delta):
	match turn:
		turnOrder.NOPLAYER:
			roll_dice()
			turn = turnOrder.PLAYER
		turnOrder.PLAYER:
			if numDiceBet != 0 and diceNumBet != 0:
				turn = turnOrder.NOTPLAYER
				npcHasBet = false
		turnOrder.NOTPLAYER:
			if !npcHasBet:
				if npc_call_or_pass() == "PASS":
					place_npc_bet()
					bluffCallChoices.show()
				else:
					wrap_up_round()
		turnOrder.GAMEOVER:
			pass
		
func my_turn_over(dieNumIndex, numDieIndex):
	diceNumBet = dieNumIndex + 1
	numDiceBet = numDieIndex + 1
	choicesButton.reset_options(numDiceBet, diceNumBet)
	textbox.queue_text("you bet " + str(numDiceBet) + " dice with " + str(diceNumBet))
	playerChoicesMenu.hide()
	
func player_called():
	wrap_up_round()
	bluffCallChoices.hide()
	
func player_passed():
	turn = turnOrder.PLAYER
	bluffCallChoices.hide()
	playerChoicesMenu.show()
	numDiceBet = 0
	diceNumBet = 0
	
func place_npc_bet():
	randomize()
	#var opponentHand = playerHands[curr_npc]
	var howMany = opponentHand.max()
	print("howmany " + str(howMany))
	var nextBet = opponentHand.find(howMany) + 1
	while nextBet < diceNumBet:
		opponentHand.pop_at(nextBet - 1)
		howMany = opponentHand.max()
		nextBet = opponentHand.find(howMany) + 1
	diceNumBet = nextBet
	numDiceBet = howMany + int(round(rand_range(0, 3)))
	textbox.queue_text("they bet " + str(numDiceBet) + " dice with " + str(diceNumBet))
	choicesButton.reset_options(numDiceBet, diceNumBet)
	npcHasBet = true
	

func npc_call_or_pass() -> String:
	if opponentHand[diceNumBet - 1] + 3 <= numDiceBet:
		return "CALL"
	else:
		return "PASS"
	
func roll_dice():
#	var onePlayerHand = []
	playerHand.resize(6)
	playerHand.fill(0)
	opponentHand.resize(6)
	opponentHand.fill(0)
	for i in range(numPlayers):
		randomize()
		for j in range(numDiceEach[i]):
			var die = int(round(rand_range(1, 6)))
			if i == 0:
				var val = playerHand.pop_at(die - 1)
				playerHand.insert(die - 1, val + 1)
			else:
				var val = opponentHand.pop_at(die - 1)
				opponentHand.insert(die - 1, val + 1)
#			onePlayerHand.insert(die - 1, val + 1)
#		playerHands.push_back(onePlayerHand)
#		print(onePlayerHand)
	for i in playerHand:
		playerLabel.text += str(i)
	for i in opponentHand:
		opponentLabel.text += str(i)
