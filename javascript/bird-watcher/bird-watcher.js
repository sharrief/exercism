// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Calculates the total bird count.
 *
 * @param {number[]} birdsPerDay
 * @returns {number} total bird count
 */
export function totalBirdCount(birdsPerDay) {
  let total = 0;
  for (let i = 0; i < birdsPerDay.length; i++) {
    total += birdsPerDay[i];
  }
  return total;
  // return ftfy(birdsPerDay).reduce((total, currentDay) => total + currentDay)
}

/**
 * Calculates the total number of birds seen in a specific week.
 *
 * @param {number[]} birdsPerDay
 * @param {number} week
 * @returns {number} birds counted in the given week
 */
export function birdsInWeek(birdsPerDay, week) {
  const weekIndex = 7 * (week - 1);
  let total = 0;
  for (let i = weekIndex; i < weekIndex + 7; i++) {
    total += birdsPerDay[i];
  }
  return total;
  // return totalBirdCount(ftfy(birdsPerDay).slice(weekIndex, weekIndex + 7));
}

/**
 * Fixes the counting mistake by increasing the bird count
 * by one for every second day.
 *
 * @param {number[]} birdsPerDay
 * @returns {void} should not return anything
 */
export function fixBirdCountLog(birdsPerDay) {
  for (let evenNumberDayIndex = 0; evenNumberDayIndex < birdsPerDay.length; evenNumberDayIndex += 2) {
    birdsPerDay[evenNumberDayIndex]++
  }
}
//
// /**
//   * Fixes the testing mistake of not inventing
//   * a better use case for `for` loops than iterating
//   * array like objects :-P
//   *
//   * @param {object} objectWithOrderdNumericKeys
//   * @returns {Array} Array containing the object properties with the lowest contiguous numeric keys
//   */
// function ftfy(objectWithOrderdNumericKeys) {
//   let key = 0;
//   const array = [];
//   while (objectWithOrderdNumericKeys[key] != null) {
//     array.push(objectWithOrderdNumericKeys[key])
//     key++
//   }
//   return array;
// }
