const std = @import("std");
pub fn squareRoot(radicand: usize) usize {
    const root = squareRootViaBinarySearch(radicand);
    // const root = squreRootViaNewtonsMethod(radicand);
    std.debug.print("root {d}\n", .{root});
    return root;
}

fn squareRootViaBinarySearch(square: usize) usize {
    if (square < 2) return square;
    var left: usize = 0;
    var right = square;
    var step: usize = 0;
    while (left < right) {
        step += 1;
        const mid = (right - left) / 2 + left;

        std.debug.print("step {d} square {d} left {d} mid {d} right {d}\n", .{ step, square, left, mid, right });
        if (mid * mid == square) return mid;
        if (mid * mid < square) left = mid else right = mid;
    }
    return left;
}

fn squareRootViaNewtonsMethod(square: usize) usize {
    if (square < 2) return square;
    var x_2: usize = 0;
    var x_1: usize = 1;
    var step: usize = 0;
    while (true) {
        step += 1;
        const curr = (x_1 + square / x_1) / 2;
        std.debug.print("step {d} square {d} curr {d} x_1 {d} x_2 {d}\n", .{ step, square, curr, x_1, x_2 });
        if (curr == x_1) return x_1;
        if (curr == x_2) return if (x_1 < curr) x_1 else curr;
        x_2 = x_1;
        x_1 = curr;
    }
}
