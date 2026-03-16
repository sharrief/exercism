// * Communicate intent precisely.
// * Edge cases matter.
// * Favor reading code over writing code.
// * Only one obvious way to do things.
// * Runtime crashes are better than bugs.
// * Compile errors are better than runtime crashes.
// * Incremental improvements.
// * Avoid local maximums.
// * Reduce the amount one must remember.
// * Focus on code rather than style.
// * Resource allocation may fail; resource deallocation must succeed.
// * Memory is a resource.
// * Together we serve the users.

/// Extracts a North American phone number from the phrase.
/// Returns null if the digits in the input don't make a valid phone number.
/// Ignores non-digits in the input.
pub fn clean(phrase: []const u8) ?[10]u8 {
    var phone_number = [_]u8{0} ** 10;
    var digit_index: usize = 0; // indexes into phone_number
    for (phrase) |char| {
        if (char < '0' or '9' < char) {
            // ignore non-digits
            continue;
        } else if (digit_index >= 10) {
            // phrase is not a phone number if it has more than 10 digits (excl opt country code)
            return null;
        } else if (digit_index == 0 and char == '1') {
            // ignore the leading NA country code
            continue;
        } else if ((digit_index == 0 or digit_index == 3) and (char == '0' or char == '1')) {
            // 0 and 1 are not allowed at indexes 0 and 3 for NA phone numbers
            return null;
        } else {
            phone_number[digit_index] = char;
            digit_index += 1;
        }
    }
    if (digit_index != 10) {
        // phone number is invalid if not exactly 10 digits
        return null;
    }
    return phone_number;
}
