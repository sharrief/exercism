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

const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    var phone_number = [_]u8{0} ** 10;
    var i: usize = 0;
    for (phrase) |char| {
        if (char < '0' or '9' < char) {
            // ignore non-numeric characters
            continue;
        } else if (i >= 10) {
            // phone number is invalid if more than 10 non-numeric numbers
            return null;
        } else if (i == 0 and char == '1') {
            // ignore the leading NA country code
            continue;
        } else if ((i == 0 or i == 3) and (char == '0' or char == '1')) {
            // 0 and 1 are not allowed at indexes 0 and 3 for NA phone numbers
            return null;
        } else {
            phone_number[i] = char;
            i += 1;
        }
    }
    if (i != 10) {
        // phone number is invalid if less than 10 non-numeric numbers
        return null;
    }
    return phone_number;
}
