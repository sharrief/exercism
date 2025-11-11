const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var acronym = std.ArrayList(u8).init(allocator);

    var letter_is_start_of_word = true;

    for (words) |char| {
        if (isLetter(char) and letter_is_start_of_word) {
            try acronym.append(capitalize(char));
            letter_is_start_of_word = false;
        } else if (isWordSeparator(char)) {
            letter_is_start_of_word = true;
        }
    }

    std.debug.print("input: {s}\noutput: {s}\n", .{ words, acronym.items });
    return try acronym.toOwnedSlice();
}

fn isLetter(char: u8) bool {
    return (('A' <= char and char <= 'Z') or
        ('a' <= char and char <= 'z'));
}

fn capitalize(char: u8) u8 {
    return if ('a' <= char and char <= 'z') char - 32 else char;
}

fn isWordSeparator(char: u8) bool {
    return (char == ' ' or
        char == 160 or // nbsp
        char == '\n' or
        char == '\r' or
        char == '\t' or
        char == '-' or
        char == '—');
}
