const std = @import("std");
const mem = std.mem;

// assuming factors are magical item base values, limit is the level
pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !usize {
    var set = std.AutoHashMap(usize, void).init(allocator);
    defer set.deinit();
    const MAX_INT: usize = std.math.maxInt(usize);

    for (factors) |base_value| {
        if (base_value < 1) continue;

        var value_mult: usize = base_value;
        while (value_mult < limit) {
            try set.put(value_mult, {});
            if ((MAX_INT - value_mult) < base_value) {
                return error.VALUE_MULT_OVERFLOW;
            }
            value_mult += base_value;
        }
    }

    var total_value: usize = 0;
    var set_iter = set.iterator();
    while (set_iter.next()) |entry| {
        if ((MAX_INT - total_value) < entry.key_ptr.*) {
            return error.TOTAL_VALUE_OVERFLOW;
        }
        total_value += entry.key_ptr.*;
    }
    return total_value;
}
