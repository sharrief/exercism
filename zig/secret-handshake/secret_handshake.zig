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

// // An enum `Signal`, needs to be implemented.
pub const Signal = enum(u5) {
    wink = 0b00001,
    double_blink = 0b00010,
    close_your_eyes = 0b00100,
    jump = 0b01000,
    reverse = 0b10000,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var handshake_signals = try ArrayList(Signal).initCapacity(allocator, 4);
    errdefer handshake_signals.deinit(allocator);

    const possible_signals_in_order = [_]Signal{ .wink, .double_blink, .close_your_eyes, .jump };
    for (possible_signals_in_order) |signal| {
        if (number & @intFromEnum(signal) != 0) {
            try handshake_signals.append(allocator, signal);
        }
    }

    if (handshake_signals.items.len > 0 and (number & @intFromEnum(Signal.reverse) != 0)) {
        var left: usize = 0;
        var right: usize = handshake_signals.items.len - 1;
        while (left < right) : ({
            left += 1;
            right -= 1;
        }) {
            const left_tmp = handshake_signals.items[left];
            const right_tmp = handshake_signals.items[right];
            handshake_signals.items[left] = right_tmp;
            handshake_signals.items[right] = left_tmp;
        }
    }
    return try handshake_signals.toOwnedSlice(allocator);
}
