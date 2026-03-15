const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    // convert number to a string to inspect the ending digits/bytes and get the ordinality
    // max of 4 digits for a number that fits in u10
    var number_string_buffer = [_]u8{0} ** 4;
    const number_string = try fmt.bufPrint(number_string_buffer[0..], "{d}", .{number});
    const number_ordinal_ending = try getOrdinalEnding(number_string);

    const greeting_len = 50;
    const greeting_buffer = try allocator.alloc(u8, greeting_len + name.len + number_string.len + number_ordinal_ending.len);
    errdefer allocator.free(greeting_buffer);
    _ = try fmt.bufPrint(greeting_buffer, "{s}, you are the {s}{s} customer we serve today. Thank you!", .{ name, number_string, number_ordinal_ending });
    return greeting_buffer;
}

const NumberParseError = error{InvalidNumber};

fn getOrdinalEnding(number_string: []u8) NumberParseError![]const u8 {
    const len = number_string.len;
    if (len >= 2 and number_string[len - 2] == '1') {
        return "th";
    } else if (len >= 1) {
        return switch (number_string[len - 1]) {
            '1' => "st",
            '2' => "nd",
            '3' => "rd",
            else => "th",
        };
    } else {
        return NumberParseError.InvalidNumber;
    }
}
