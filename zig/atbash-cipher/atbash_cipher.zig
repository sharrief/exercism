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
const ascii = std.ascii;
const debug = std.debug;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, input: []const u8) mem.Allocator.Error![]u8 {
    return mirrorAlphabeticCharacters(allocator, input, 5);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, input: []const u8) mem.Allocator.Error![]u8 {
    return mirrorAlphabeticCharacters(allocator, input, null);
}

fn mirrorAlphabeticCharacters(allocator: mem.Allocator, input: []const u8, word_len: ?usize) mem.Allocator.Error![]u8 {
    var mirrored_input = ArrayList(u8).empty;
    defer mirrored_input.deinit(allocator);

    var next_whitespace: ?usize = word_len;
    for (input) |char| {
        if (!ascii.isAlphanumeric(char)) continue;
        if (next_whitespace) |*value| {
            if (value.* == 0) {
                try mirrored_input.append(allocator, ' ');
                value.* = word_len.?;
            }
            value.* -= 1;
        }
        if (!ascii.isAlphabetic(char))
            try mirrored_input.append(allocator, char)
        else
            try mirrored_input.append(allocator, getMirrorAlphabeticCharacter(char));
    }
    return mirrored_input.toOwnedSlice(allocator);
}

/// Returns the character at the same index in the reversed alphabet
fn getMirrorAlphabeticCharacter(char: u8) u8 {
    return ascii.lowercase[getAlphabeticIndex('z') - getAlphabeticIndex(char)];
}

/// Normalizes letters to a zero-based index with 'a' at zero
fn getAlphabeticIndex(char: u8) u8 {
    const zero_index_char: u8 = if (ascii.isUpper(char)) 'A' else 'a';
    return char - zero_index_char;
}
