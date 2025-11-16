const std = @import("std");

pub const ColorBand = enum {
    black,
    brown,
    red,
    orange,
    yellow,
    green,
    blue,
    violet,
    grey,
    white,
};

pub fn colorCode(color: ColorBand) usize {
    const code: usize = switch (color) {
        .black => 0,
        .brown => 1,
        .red => 2,
        .orange => 3,
        .yellow => 4,
        .green => 5,
        .blue => 6,
        .violet => 7,
        .grey => 8,
        .white => 9
    };
    return code;
}

var all_colors: [10]ColorBand = undefined;
pub fn colors() []const ColorBand {
    all_colors[0] = ColorBand.black;
    all_colors[1] = ColorBand.brown;
    all_colors[2] = ColorBand.red;
    all_colors[3] = ColorBand.orange;
    all_colors[4] = ColorBand.yellow;
    all_colors[5] = ColorBand.green;
    all_colors[6] = ColorBand.blue;
    all_colors[7] = ColorBand.violet;
    all_colors[8] = ColorBand.grey;
    all_colors[9] = ColorBand.white;
    return all_colors[0..10];
}
