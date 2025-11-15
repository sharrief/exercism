const std = @import("std");

pub fn colorCode(colors: [2]ColorBand) usize {
    const band_one_value = colorValue(colors[0]);
    const band_two_value = colorValue(colors[1]);
    return band_one_value * 10 + band_two_value;
}

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

 fn colorValue(color: ColorBand) usize {
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
