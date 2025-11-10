const std = @import("std");

pub fn score(s: []const u8) u32 {
    var total_score: u32 = 0;
    const MAX_SCORE: u32 = 0xffff_ffff;
    for (s) |char| {
        const noramlized_char: u8 = if (char >= 97) char - 32 else char;
        const char_score: u32 = switch (noramlized_char) {
            'A', 'E', 'I', 'O', 'U' => 1,
            'L', 'N', 'R', 'S', 'T' => 1,
            'D', 'G' => 2,
            'B', 'C', 'M', 'P' => 3,
            'F', 'H', 'V', 'W', 'Y' => 4,
            'K' => 5,
            'J', 'X' => 8,
            'Q', 'Z' => 10,
            else => 0,
        };
        if ((MAX_SCORE - total_score) < char_score) {
            // u32 overflow, return current score
            return total_score;
        } else {
            total_score += char_score;
        }
    }
    std.debug.print("{s}: {d}\n", .{s, total_score});
    return total_score;
}
