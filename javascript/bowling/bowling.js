//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//



/**
 * Manages the stateful score of a game of bowling for one player
 * @class
 */
export class Bowling {
  /** 
   * The array of throws for the game
   * @type {(number|null)[]}  
   */
  throws = []
  /**
   * The number of extra times a throw scores
   * @type {number[]}
   */
  bonus = []
  /**
   * 1-based index that tracks which boxes have been scored
   * @type {number}
   */
  completedBoxNumber = 0

  constructor() {
    this.throws = new Array(23).fill(null)
    this.bonus = new Array(23).fill(0)
  }

  /**
  * @param {number} pins The number of pins downed in a throw
  */
  roll(pins) {
    if (pins < 0) throw new Error('Negative roll is invalid')
    if (pins > 10) throw new Error('Pin count exceeds pins on the lane')
    if (this.completedBoxNumber <= 20 && (this.completedBoxNumber + 1) % 2 == 0 && this.throws[this.completedBoxNumber] + pins > 10) throw new Error('Pin count exceeds pins on the lane')
    if (this.completedBoxNumber > 20 && (this.throws[this.completedBoxNumber] != 10 && pins != 10) && this.throws[this.completedBoxNumber] + pins > 10) throw new Error('Pin count exceeds pins on the lane')
    if (this.completedBoxNumber == 21 && this.throws[this.completedBoxNumber] != )

      if (this.completedBoxNumber < 20
        || this.completedBoxNumber === 20 && this.bonus[21]
        || this.completedBoxNumber === 21 && this.bonus[22]
      )
        this.throws[++this.completedBoxNumber] = pins
      else throw new Error('Cannot roll after game is over')


    // handle bonus scoring
    if (this.completedBoxNumber <= 20) {
      // spares can only occur on even box numbers
      const isEvenBoxNumber = this.completedBoxNumber % 2 === 0
      const previousThrowScore = this.throws[this.completedBoxNumber - 1]
      if (isEvenBoxNumber && previousThrowScore == null) throw new Error("Previous throw score should never be null for an even box number")
      const isSpare = isEvenBoxNumber && (previousThrowScore + pins === 10)
      const isStrike = !isSpare && pins === 10
      if (isSpare) {
        this.bonus[this.completedBoxNumber + 1]++
      } else if (isStrike) {
        // a stike skips to the next frame
        if (this.throws[++this.completedBoxNumber] != null) throw new Error("The box after a strike should always be null")
        // if there was already bonus for this box number, move it to the next potential throw
        this.bonus[this.completedBoxNumber + 1] += this.bonus[this.completedBoxNumber]
        this.bonus[this.completedBoxNumber] = 0
        // add the bonuses for this strike
        this.bonus[this.completedBoxNumber + 1]++
        this.bonus[this.completedBoxNumber + 2]++
      }
    }
  }

  score() {
    if (this.completedBoxNumber < 20
      || this.completedBoxNumber === 20 && this.bonus[21]
      || this.completedBoxNumber === 21 && this.bonus[22])
      throw new Error('Score cannot be taken until the end of the game')

    let total = 0;
    for (const [boxNumber, pins] of this.throws.entries()) {
      if (boxNumber === 0) continue
      if (pins == null) continue
      const bonus = boxNumber <= 20 ? (this.bonus[boxNumber] * pins) : 0
      total += pins + bonus
      console.log("boxNumber: " + boxNumber + " total:" + total)
    }
    console.log(this.throws)
    console.log(this.bonus)
    return total
  }
}
