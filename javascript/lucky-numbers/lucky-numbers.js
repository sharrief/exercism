// @ts-check

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  return numArrayToInt(array1) + numArrayToInt(array2)
}

/**
 * @param {number[]} array An array of digits
 * @returns {number} The number representing the joined digits
 */
function numArrayToInt(array) {
  return Number(array.join(''))
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean} whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  const valueString = value + ''
  for (let i = 0; i < valueString.length / 2; i++) {
    if (valueString[i] != valueString[valueString.length - 1 - i])
      return false;
  }
  return true;
  // return Number((value + '').split('').reverse().join('')) == value;
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (input == null || input.length < 1) return 'Required field'
  if (isNaN(+input) || !+input) return 'Must be a number besides 0'
  return ''
}
