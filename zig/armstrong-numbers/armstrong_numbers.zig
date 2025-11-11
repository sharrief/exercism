const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) return true;

    // count the number of digits
    const MAX_INT = std.math.maxInt(u128);
    var num_of_digits: u128 = 0;
    var curr = num;
    while (curr > 0) {
        num_of_digits += 1;
        if (MAX_INT == num_of_digits) return false;
        curr /= 10;
    }

    // sum each digit raised to the number of digits
    var sum_of_raised_digits: u128 = 0;
    curr = num;
    while (curr > 0) {
        const digit = curr % 10;
        const addend = std.math.pow(u128, digit, num_of_digits);
        if ((MAX_INT - sum_of_raised_digits) < addend) return false;
        sum_of_raised_digits += addend;
        curr /= 10;
    }
    return sum_of_raised_digits == num;
}
