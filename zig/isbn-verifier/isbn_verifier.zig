const std = @import("std");

/// Determines if the provided string is a valid ISBN-10 number.
/// Ignores hypens and returns false on any non 0-9 or 'X' character.
/// Requires the digits in the number to satisfy the formula (sum(digit[n] * 10-n) for digit n of 10) modulo 11 == 0
pub fn isValidIsbn10(inputString: []const u8) bool {
    var digit_count: usize = 0;
    var sum: usize = 0;

    for (inputString, 0..) |char, i| {
        if (char == '-') {
            continue;
        }
        const value = switch (char) {
            '0'...'9' => std.fmt.parseInt(u8, inputString[i .. i + 1], 10) catch unreachable,
            'X' => 10,
            else => return false, // invalid character in the input
        };

        if (value == 10 and digit_count < 9) {
            // the check value 'X' must be the 10th digit to be valid
            return false;
        } else if (digit_count >= 10) {
            return false;
        }

        sum += value * (10 - digit_count);
        digit_count += 1;
    }

    if (digit_count < 10) {
        return false;
    }

    return sum % 11 == 0;
}
