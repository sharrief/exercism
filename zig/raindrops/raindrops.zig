const std = @import("std");
// Converts the ordinality of a raindrop into a string representing its sound.
// Every 3rd, 5th and 7th raindrop emits a special sound.
pub fn convert(buffer: []u8, n: u32) []const u8 {
    if (listenToRaindrop(buffer, n)) |sound| {
        return sound;
    } else {
        return printRaindrop(buffer, n) catch |err| {
            _ = std.io.getStdErr().writer().print("ERROR -> convert(buffer = [{}]u8, n = {}) -> {}\n", .{ buffer.len, n, err }) catch {};
            return buffer;
        };
    }
}

fn listenToRaindrop(buffer: []u8, n: u32) ?[]const u8 {
    if (buffer.len < 15) {
        _ = std.io.getStdErr().writer().print("WARN: convert(buffer = [{}]u8, n = {}) -> cannot print sounds with buffer length < 15\n", .{ buffer.len, n }) catch {};
        return null;
    }
    const Raindrop = struct { periodicity: u8, sound: []const u8 };
    const raindrops: []const Raindrop = &.{
        .{ .periodicity = 3, .sound = "Pling" },
        .{ .periodicity = 5, .sound = "Plang" },
        .{ .periodicity = 7, .sound = "Plong" },
    };
    var strLen: usize = 0;
    for (raindrops) |raindrop| {
        if (n % raindrop.periodicity == 0) {
            @memcpy(buffer[strLen .. strLen + raindrop.sound.len], raindrop.sound);
            strLen += raindrop.sound.len;
        }
    }

    if (strLen > 0) return buffer[0..strLen];
    return null;
}

fn printRaindrop(buffer: []u8, n: u32) ![]const u8 {
    // determine the length of the printed number
    // by counting the number of digits in the number
    const f: f64 = @floatFromInt(n);
    const powerOf10 = std.math.log10(f);
    const wholePowerOf10: usize = @intFromFloat(@floor(powerOf10));
    const strLen = wholePowerOf10 + 1;

    if (strLen <= buffer.len) {
        _ = try std.fmt.bufPrint(buffer[0..], "{d}", .{n});
        return buffer[0..strLen];
    }
    return error.BufferTooSmall;
}

pub fn main() void {
    const inputs = [_]u8{ 3, 5, 7, 3 * 5, 3 * 5 * 7, 5 * 7, 3 * 7, 13 };
    for (inputs) |input| {
        var buffer = [_]u8{' '} ** 15;
        const result = convert(&buffer, input);
        std.debug.print("{s}\n", .{result});
    }
}
