const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    const indicies_of_starting_letters = try allocator.alloc(usize, words.len);
    defer allocator.free(indicies_of_starting_letters);

    var num_starting_letters: usize = 0;
    var letter_is_start_of_word = true;

    for (words, 0..) |char, idx_of_char| {
        if (isLetter(char) and letter_is_start_of_word) {
            indicies_of_starting_letters[num_starting_letters] = idx_of_char;
            num_starting_letters += 1;
            letter_is_start_of_word = false;
        } else if (isWordSeparator(char)) {
            letter_is_start_of_word = true;
        }
    }

    const acronym = try allocator.alloc(u8, num_starting_letters);
    var acronym_size: usize = 0;
    for (0..num_starting_letters) |i| {
        acronym[acronym_size] = capitalize(words[indicies_of_starting_letters[i]]);
        acronym_size += 1;
    }
    std.debug.print("input: {s}\noutput: {s}\n", .{ words, acronym });
    return acronym;
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
