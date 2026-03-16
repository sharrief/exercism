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
const mem = std.mem;
const ArrayList = std.ArrayList;
const sqrt = std.math.sqrt;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var factor_list = try ArrayList(u64).initCapacity(allocator, 1);
    defer factor_list.deinit(allocator);

    if (value < 2) {
        // Only integers 2 or greater have prime factors
        return try factor_list.toOwnedSlice(allocator);
    }

    var numerator: u64 = value;
    var denominator: u64 = 2;
    // if the denominator is greater than the sqrt,
    // then there are no greater factors to explore
    while (denominator <= sqrt(numerator)) {
        if (@mod(numerator, denominator) == 0) {
            try factor_list.append(allocator, denominator);
            numerator = @divExact(numerator, denominator);
        } else if (denominator == 2) {
            denominator = 3;
        } else {
            denominator += 2;
        }
    }

    if (numerator > 1) {
        // the numerator could not be further divided, so it is the final prime factor
        try factor_list.append(allocator, numerator);
    }

    return try factor_list.toOwnedSlice(allocator);
}
