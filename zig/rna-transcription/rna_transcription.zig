const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    for (dna, 0..) |char, i| {
        const rna_char: u8 = switch (char) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => 'X',
        };
        rna[i] = rna_char;
    }
    return rna;
}
