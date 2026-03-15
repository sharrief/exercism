/// Determines if the provided string is a valid ISBN-10 number.
/// Ignores hypens and returns false on any non 0-9 or 'X' character.
/// Requires the digits in the number to satisfy the formula (sum(digit[n] * 10-n) for digit n of 10) modulo 11 == 0
pub fn isValidIsbn10(inputString: []const u8) bool {
    var multiplier: usize = 10;
    var sum: usize = 0;

    for (inputString) |char| {
        if (multiplier < 1) {
            // a non-dash character after processing all digits means the input is invalid
            return false;
        } else if (char == '-') {
            // dashes are ignored in any part of the input
            continue;
        }

        const value = switch (char) {
            '0'...'9' => char - '0',
            'X' => blk: {
                if (multiplier != 1) {
                    // if present, the check value 'X' must be the last/10th digit to be valid
                    return false;
                }
                break :blk 10;
            },
            else => return false, // there is an invalid character in the input
        };
        sum += value * multiplier;
        multiplier -= 1;
    }

    if (multiplier > 0) {
        // we didn't find 10 digits in the input
        return false;
    }

    return sum % 11 == 0;
}
