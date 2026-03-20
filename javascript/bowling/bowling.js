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
   * The current number of pins standing
   * @param {number}
   */
  pinsUp = 0
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
    this.pinsUp = 10
    this.throws = new Array(25).fill(null)
    this.bonus = new Array(25).fill(0)
  }

  /**
  * @param {number} pinsDowned The number of pins downed in a throw
  */
  roll(pinsDowned) {
    if (pinsDowned < 0) throw new Error('Negative roll is invalid')
    if (pinsDowned > pinsUp) throw new Error('Pin count exceeds pins on the lane')

    if (this.completedBoxNumber >= 20 && !this.bonus[this.completedBoxNumber + 1])
      throw new Error('Cannot roll after game is over')

    this.throws[++this.completedBoxNumber] = pinsDowned
    this.pinsUp -= pinsDowned

    // handle bonus scoring
    const isEvenBoxNumber = this.completedBoxNumber % 2 === 0
    const isSpare = isEvenBoxNumber && this.pinsUp === 0
    const isStrike = !isSpare && this.pinsUp === 0
    const isFillBall = this.completedBoxNumber > 20
    if (isSpare && !isFillBall) this.bonus[this.completedBoxNumber + 1]++
    if (isStrike) {
      this.bonus[this.completedBoxNumber + 1] += this.bonus[this.completedBoxNumber]
      this.bonus[this.completedBoxNumber] = 0
      this.completedBoxNumber++
      if (!isFillBall) {
        // add the bonuses for this strike
        this.bonus[this.completedBoxNumber + 1]++
        this.bonus[this.completedBoxNumber + 2]++
      }
    }
    if (isStrike || this.completedBoxNumber % 2 == 0) {
      // reset the pins
      this.pinsUp = 10
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
