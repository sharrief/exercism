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
const assert = std.debug.assert;

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
/// Returns whether n is a perfect, deficient or abundant number
pub fn classify(n: u64) Classification {
    assert(n != 0);
    var sum: usize = 0;
    for (1..n) |potential_factor| {
        if (potential_factor > @divFloor(n, 2)) {
            break;
        } else if (n % potential_factor == 0) {
            sum += potential_factor;
        }
    }
    if (n == sum) {
        return .perfect;
    } else if (n > sum) {
        return .deficient;
    } else {
        return .abundant;
    }
}
