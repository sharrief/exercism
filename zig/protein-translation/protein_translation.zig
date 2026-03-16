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

pub const TranslationError = error{
    InvalidCodon,
};

const sequence_len = 3;

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var protein_list = try std.ArrayList(Protein).initCapacity(allocator, strand.len / sequence_len);
    defer protein_list.deinit(allocator);

    var sequence_start: usize = 0;
    while (sequence_start < strand.len) : (sequence_start += sequence_len) {
        const sequence_end = sequence_start + sequence_len;
        if (sequence_end > strand.len) {
            // Need at least 3 consecutive chars to parse a codon
            return TranslationError.InvalidCodon;
        }
        const char_sequence = strand[sequence_start..sequence_end][0..sequence_len].*;
        const codon = try parseCodon(char_sequence);
        const protein = getProtein(codon);
        if (protein == .STOP) {
            break;
        }
        try protein_list.append(allocator, protein);
    }
    return try protein_list.toOwnedSlice(allocator);
}

const Codon = enum(u24) {
    AUG = 'A' | 'U' << 8 | 'G' << 16,

    UUU = 'U' | 'U' << 8 | 'U' << 16,
    UUC = 'U' | 'U' << 8 | 'C' << 16,

    UUA = 'U' | 'U' << 8 | 'A' << 16,
    UUG = 'U' | 'U' << 8 | 'G' << 16,

    UCU = 'U' | 'C' << 8 | 'U' << 16,
    UCC = 'U' | 'C' << 8 | 'C' << 16,
    UCA = 'U' | 'C' << 8 | 'A' << 16,
    UCG = 'U' | 'C' << 8 | 'G' << 16,

    UAU = 'U' | 'A' << 8 | 'U' << 16,
    UAC = 'U' | 'A' << 8 | 'C' << 16,

    UGU = 'U' | 'G' << 8 | 'U' << 16,
    UGC = 'U' | 'G' << 8 | 'C' << 16,

    UGG = 'U' | 'G' << 8 | 'G' << 16,

    UAA = 'U' | 'A' << 8 | 'A' << 16,
    UAG = 'U' | 'A' << 8 | 'G' << 16,
    UGA = 'U' | 'G' << 8 | 'A' << 16,
};

fn parseCodon(char_sequence: [3]u8) !Codon {
    const maybe_codon: u24 = @bitCast(char_sequence);
    return std.enums.fromInt(Codon, maybe_codon) orelse TranslationError.InvalidCodon;
}

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
    STOP,
};

fn getProtein(codon: Codon) Protein {
    return switch (codon) {
        .AUG => .methionine,
        .UUU, .UUC => .phenylalanine,
        .UUA, .UUG => .leucine,
        .UCU, .UCC, .UCA, .UCG => .serine,
        .UAU, .UAC => .tyrosine,
        .UGU, .UGC => .cysteine,
        .UGG => .tryptophan,
        .UAA, .UAG, .UGA => .STOP,
    };
}
