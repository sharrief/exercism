const std = @import("std");

pub const ChessboardError = error{
    IndexOutOfBounds,
};

pub fn square(index: usize) ChessboardError!u64 {
    if (index < 1 or 64 < index) return ChessboardError.IndexOutOfBounds;
    return std.math.pow(u64, 2, index - 1);
}

pub fn total() u64 {
    var sum: u64 = 0;
    for (1..65) |index| {
        sum += square(index) catch |err| blk: {
            std.debug.print("{any}: {d}\n", .{ err, index });
            break :blk 0;
        };
    }
    return sum;
}
