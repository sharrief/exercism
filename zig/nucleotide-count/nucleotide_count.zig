const std = @import("std");
pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32,
    c: u32,
    g: u32,
    t: u32,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var counts: Counts = .{ .a = 0, .c = 0, .g = 0, .t = 0 };
    for (s) |char| {
        switch (char) {
            'A' => counts.a += 1,
            'C' => counts.c += 1,
            'G' => counts.g += 1,
            'T' => counts.t += 1,
            else => return NucleotideError.Invalid,
        }
    }
    // std.debug.print("{}", .{counts});
    return counts;
}

pub fn main() !void {
    _ = try countNucleotides("AACCCGGGGTT");
}
