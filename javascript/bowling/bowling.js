//
// This is only a SKELETON file for the 'Bowling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const debug = false
/**
 * Manages the stateful score of a game of bowling for one player
 * @class
 */
export class Bowling {
  /**
    * 1-based index that tracks which boxes have been scored.
    * Every Frame consists of 2 boxes. Box number 0 is ignored.
    * @type {number}
    */
  boxNumber = 1 /** 

  /**
   * Convenience getter for deteriming which throw of a frame the game is in
   */
  get isSecondThrowOfFrame() {
    return this.boxNumber % 2 == 0
  }

  /**
   * Convenience getter for calculating the Frame number
   * @type {number}
   */
  get frameNumber() {
    return Math.floor((this.boxNumber + 1) / 2)
  }

  /** The 1-based index array of scores for each box.
   * @type {(number | null)[]}  
   */
  boxScores = new Array(23).fill(null)

  /**
   * The current number of pins standing
   * @param {number}
   */
  pinsStanding = 10

  /**
   * The number of extra times a throw scores for the box number at that index.
   * Spares and Strikes increase the multiplier for following throws.
   * @type {number[]}
   */
  boxScoreMultipliers = new Array(23).fill(0)

  /**
   * Tracks the number of fill balls earned in the last frame
   * @type {number}
   */
  fillBalls = 0

  /**
  * Updates the state of the game when pins are knocked down
  * @param {number} pinsDowned The number of pins downed in a throw
  */
  roll(pinsDowned) {
    if (this.boxNumber > (20 + this.fillBalls))
      throw new Error('Cannot roll after game is over')

    if (pinsDowned < 0) throw new Error('Negative roll is invalid')
    if (pinsDowned > this.pinsStanding) throw new Error('Pin count exceeds pins on the lane')

    this.boxScores[this.boxNumber] = pinsDowned
    this.pinsStanding -= pinsDowned

    if (this.pinsStanding === 0 && this.frameNumber <= 10)
      this.isSecondThrowOfFrame ? this._handleSpareBonus() : this._handleStrikeBonus()


    if (this.pinsStanding === 0 || this.isSecondThrowOfFrame) this.pinsStanding = 10
    this.boxNumber++
    if (debug) this.printScore()
  }

  _handleSpareBonus() {
    if (this.frameNumber === 10) this.fillBalls += 1
    if (this.frameNumber <= 9)
      this.boxScoreMultipliers[this.boxNumber + 1]++
  }

  _handleStrikeBonus() {
    if (this.frameNumber <= 10) this.boxNumber++ // a non-fill-ball strike fills the frame
    if (this.frameNumber === 10) this.fillBalls += 2
    if (this.frameNumber <= 9) { // earned bonuses for the next non-fill-ball frame
      this.boxScoreMultipliers[this.boxNumber + 1]++
      this.boxScoreMultipliers[this.boxNumber + 2]++
    }
    // If the second throw of the frame had a bonus, roll it over to the next throw
    if (this.boxScoreMultipliers[this.boxNumber] > 0) {
      this.boxScoreMultipliers[this.boxNumber + 1] += this.boxScoreMultipliers[this.boxNumber]
      this.boxScoreMultipliers[this.boxNumber] = 0
    }
  }

  score() {
    if (this.boxNumber <= (20 + this.fillBalls))
      throw new Error('Score cannot be taken until the end of the game')

    let total = 0;
    for (const [boxNumber, boxScore] of this.boxScores.entries()) {
      if (boxNumber === 0) continue
      if (boxScore == null) continue // frame filled by strike
      const bonus = this.boxScoreMultipliers[boxNumber] * boxScore
      total += boxScore + bonus
    }
    return total
  }

  printScore() {
    const frameNumbers = '|' + Array(10).fill(0).map((_, i) => {
      return `${i + 1}`.padEnd(3, ' ')
    }).join('|') + '|----'

    const throws = this.boxScores.map((pins, boxNumber, all) => {
      if (boxNumber === 0) return ''
      if (boxNumber % 2 === 0 && pins > 0 && pins < 10 && all[boxNumber - 1] + pins === 10)
        return '/'
      if (pins === 10)
        return 'X'
      if (pins != null)
        return `${pins}`
      return ' '
    }).join('|')

    const multipliers = this.boxScoreMultipliers.map((mult, boxNumber) => {
      if (boxNumber === 0) return ''
      if (mult === 0) return ' '
      return mult
    }).join('|')

    console.log(frameNumbers + '\n' + throws + '\n' + multipliers)
  }
}
