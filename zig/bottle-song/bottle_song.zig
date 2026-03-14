const std = @import("std");

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    if (take_down > start_bottles) {
        return error.NotEnoughBottles;
    }

    var taken: u32 = 0;
    var total_printed: usize = 0;

    while (taken < take_down) {
        if (taken > 0) {
            const printed = try std.fmt.bufPrint(buffer[total_printed..], "\n\n", .{});
            total_printed += printed.len;
        }

        const current_bottles, const current_plurality = getSpellingAndPlurality(start_bottles - taken);
        taken += 1;
        const remaining_bottles, const remaining_plurality = getSpellingAndPlurality(start_bottles - taken);

        const printed = try std.fmt.bufPrint(buffer[total_printed..],
            \\{0c}{1s} green bottle{2s} hanging on the wall,
            \\{0c}{1s} green bottle{2s} hanging on the wall,
            \\And if one green bottle should accidentally fall,
            \\There'll be {3s} green bottle{4s} hanging on the wall.
        , .{ std.ascii.toUpper(current_bottles[0]), current_bottles[1..], current_plurality, remaining_bottles, remaining_plurality });

        total_printed += printed.len;
    }
    return buffer[0..total_printed];
}

fn getSpellingAndPlurality(number: usize) struct { []const u8, []const u8 } {
    const number_spelling = blk: {
        switch (number) {
            0 => break :blk "no",
            1 => break :blk "one",
            2 => break :blk "two",
            3 => break :blk "three",
            4 => break :blk "four",
            5 => break :blk "five",
            6 => break :blk "six",
            7 => break :blk "seven",
            8 => break :blk "eight",
            9 => break :blk "nine",
            10 => break :blk "ten",
            else => break :blk "a number of",
        }
    };
    const plurality = blk: {
        if (number == 1) break :blk "";
        break :blk "s";
    };
    return .{ number_spelling, plurality };
}
