const std = @import("std");

pub fn squareOfSum(n: usize) usize {
    // sum of n numbers
    // (n(n+1)/2)
    const sum_of_n_integers = (n * (n + 1)) / 2;
    return std.math.pow(usize, sum_of_n_integers, 2);
}

pub fn sumOfSquares(n: usize) usize {
    // Faulhaber's formula for p=2
    // (n(n + 1)(2n + 1))/6
    return (n * (n + 1) * ((2 * n) + 1)) / 6;
}

pub fn differenceOfSquares(number: usize) usize {
    const sum_of_sq = sumOfSquares(number);
    const sq_of_sum = squareOfSum(number);
    if (sum_of_sq > sq_of_sum) return sum_of_sq - sq_of_sum;
    return sq_of_sum - sum_of_sq;
}
