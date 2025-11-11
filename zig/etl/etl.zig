const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var new_legacy = std.AutoHashMap(u8, i5).init(allocator);
    var legacy_iter = legacy.iterator();

    while (legacy_iter.next()) |legacy_entry| {
        const score = legacy_entry.key_ptr.*;
        for (legacy_entry.value_ptr.*) |letter| {
            try new_legacy.put(lowercase(letter), score);
        }
    }
    return new_legacy;
}

fn lowercase(char: u8) u8 {
    return if ('A' <= char and char <= 'Z') char + 32 else char;
}
