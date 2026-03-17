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

pub fn rotate(allocator: mem.Allocator, message: []const u8, shift_key: u5) mem.Allocator.Error![]u8 {
    var rotated_message = try std.ArrayList(u8).initCapacity(allocator, message.len);
    errdefer rotated_message.deinit(allocator);
    for (message) |char| {
        // re-index letters to 0 to enable modular arithmetic when shifting letters
        const zero_char_opt: ?u8 = blk: {
            if ('A' <= char and char <= 'Z') {
                break :blk 'A';
            } else if ('a' <= char and char <= 'z') {
                break :blk 'a';
            } else {
                break :blk null;
            }
        };
        if (zero_char_opt) |zero_char| {
            const zero_based_char_index = char - zero_char;
            const zero_based_rotated_char_index = (zero_based_char_index + shift_key) % 26;
            try rotated_message.append(allocator, zero_char + zero_based_rotated_char_index);
        } else {
            try rotated_message.append(allocator, char);
        }
    }
    return rotated_message.toOwnedSlice(allocator);
}
