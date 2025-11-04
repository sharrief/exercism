const std = @import("std");
pub fn convert(buffer: []u8, n: u32) []const u8 {
    // track the number of bytes written to the buffer
    var strLen: usize = 0;

    if (buffer.len >= 15) {
        if (n % 3 == 0) {
            @memcpy(buffer[strLen .. strLen + 5], "Pling");
            strLen = strLen + 5;
        }
        if (n % 5 == 0) {
            @memcpy(buffer[strLen .. strLen + 5], "Plang");
            strLen = strLen + 5;
        }
        if (n % 7 == 0) {
            @memcpy(buffer[strLen .. strLen + 5], "Plong");
            strLen = strLen + 5;
        }
    }
    if (strLen == 0) {
        // determine the length of the formatted number
        // by counting the number of digits in the number
        const f: f64 = @floatFromInt(n);
        const powerOf10 = std.math.log10(f);
        const wholePowerOf10: usize = @intFromFloat(@floor(powerOf10));
        strLen = wholePowerOf10 + 1;

        if (strLen <= buffer.len) {
            _ = std.fmt.bufPrint(buffer[0..], "{d}", .{n}) catch {
                // can't change fn signature to error union or test fails
            };
        } else {
            strLen = buffer.len;
        }
    }
    return buffer[0..strLen];
}

pub fn main() void {
    const inputs = [_]u8{ 3, 5, 7, 3 * 5, 3 * 5 * 7, 5 * 7, 3 * 7, 13 };
    for (inputs) |input| {
        var buffer = [_]u8{' '} ** 15;
        const result = convert(&buffer, input);
        std.debug.print("{s}\n", .{result});
    }
}
