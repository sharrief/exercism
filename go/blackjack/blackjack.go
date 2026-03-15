package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "two":
		return 2
	case "three":
		return 3
	case "four":
		return 4
	case "five":
		return 5
	case "six":
		return 6
	case "seven":
		return 7
	case "eight":
		return 8
	case "nine":
		return 9
	case "ten":
		fallthrough
	case "jack":
		fallthrough
	case "queen":
		fallthrough
	case "king":
		return 10
	}
	return 0
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	value1 := ParseCard(card1)
	value2 := ParseCard(card2)
	dealerValue := ParseCard(dealerCard)

	handValue := value1 + value2
	switch {
	case value1 == value2 && value1 == 11:
		return "P"

	case handValue >= 21:
		if dealerValue >= 10 {
			return "S"
		}
		return "W"

	case 17 <= handValue && handValue <= 20:
		return "S"

	case 12 <= handValue && handValue <= 16:
		if dealerValue >= 7 {
			return "H"
		}
		return "S"

	default:
		return "H"
	}
}
