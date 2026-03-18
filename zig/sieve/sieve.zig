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

/// Uses The Sieve of Eratosthenes to identify non-primes by marking the multiples of primes and filtering them from the output.
/// Only calculates primes up to the specificed limit that fit into the supplied buffer.
pub fn primes(buffer: []u32, limit: u12) []u32 {
    if (limit < 2) return buffer[0..0];

    // Bitmask large enough to mark numbers up to the maximum limit 2^12 = 4096
    var marked_numbers: u4096 = 0;

    var buffer_idx: usize = 0;
    for (2..limit + 1) |n| {
        const number: u12 = @truncate(n);

        if (isMarked(marked_numbers, number)) continue;

        var multiple = number +| number;

        while (multiple <= limit) : (multiple +|= number) {
            marked_numbers |= getBitmask(multiple);
            if (multiple == limit) break;
        }

        buffer[buffer_idx] = @intCast(number);
        buffer_idx += 1;
    }
    return buffer[0..buffer_idx];
}

fn isMarked(marked_numbers: u4096, number: u12) bool {
    return marked_numbers & getBitmask(number) != 0;
}

fn getBitmask(number: u12) u4096 {
    return (@as(u4096, 1) << number);
}
