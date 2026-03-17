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
const ArrayList = std.ArrayList;
const mem = std.mem;
const fmt = std.fmt;

const repeating_template = "For want of a {s} the {s} was lost.\n";
const ending_template = "And all for the want of a {s}.\n";

pub fn recite(allocator: mem.Allocator, things: []const []const u8) mem.Allocator.Error![][]u8 {
    var proverb = try ArrayList([]u8).initCapacity(allocator, things.len);
    // toOwnedSlice will free the ArrayList on success
    errdefer {
        // when an error is returned the caller cannot access the lines to free them
        for (proverb.items) |line| {
            allocator.free(line);
        }
        proverb.deinit(allocator);
    }

    if (things.len > 0) {
        const originally_wanted_thing = things[0];
        var currently_wanted_thing = originally_wanted_thing;
        for (things) |lost_thing| {
            if (mem.eql(u8, lost_thing, originally_wanted_thing)) {
                // never lost the originally_wanted_thing
                continue;
            }
            const line = try fmt.allocPrint(allocator, repeating_template, .{ currently_wanted_thing, lost_thing });
            try proverb.append(allocator, line);
            currently_wanted_thing = lost_thing;
        }

        const ending = try fmt.allocPrint(allocator, ending_template, .{originally_wanted_thing});
        try proverb.append(allocator, ending);
    }
    return proverb.toOwnedSlice(allocator);
}
