const std = @import("std");

const allLetterFlagsEnabled: u26 = 0b11111111111111111111111111;
const debugging = true;

pub fn isPangram(str: []const u8) bool {
    var lettersFlaggedInPangram: u26 = 0;
    for (str) |char| {
        // 2^5 is enough to count the 26 English letters
        var letterIndexInAlphabet: u5 = undefined;
        if ('A' <= char and char <= 'Z') {
            letterIndexInAlphabet = @intCast(char - 'A');
        } else if ('a' <= char and char <= 'z') {
            letterIndexInAlphabet = @intCast(char - 'a');
        } else {
            // skip non-English letter character codes
            continue;
        }
        debug("Letter {c} index {d}\n", .{ char, letterIndexInAlphabet });
        // set flag for letter at this index
        lettersFlaggedInPangram |= @as(u26, 1) << letterIndexInAlphabet;
        debug("Flags: {b:026}\n", .{lettersFlaggedInPangram});
    }
    return lettersFlaggedInPangram == allLetterFlagsEnabled;
}

fn debug(comptime fmt: []const u8, args: anytype) void {
    if (!debugging) {
        return;
    }
    std.debug.print(fmt, args);
}

pub fn main() void {
    const result = isPangram("The quick brown fox jumps over the lazy dog.");
    debug("isPangram {}", .{result});
}
