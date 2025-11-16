const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum(u8) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

// converts [orange, green, blue] -> (30 + 5) * 10^6 -> "35 megaohms"
pub fn label(allocator: mem.Allocator, color_bands: []const ColorBand) mem.Allocator.Error![]u8 {
    var ohms: f64 = 0;
    var prefix: []const u8 = "";
    // bands[0] is the 10s digit
    // bands[1] is the 1s digit
    // combine those to get the base value
    // bands[2] is the power of 10 to multiply by the base value
    for (color_bands, 1..) |color_band, i| {
        const band_value: f64 = @floatFromInt(@intFromEnum(color_band));
        switch (i) {
            1 => ohms += band_value * 10,
            2 => ohms += band_value,
            3 => {
                ohms *= std.math.pow(f64, 10, band_value);
                // replace the 1,000s separators with the metric prefix
                var power_of_1000: usize = 0;
                while (ohms >= 1000) {
                    ohms /= 1000;
                    power_of_1000 += 1;
                }
                prefix = getMetricPrefix(power_of_1000);
            },
            else => break,// only 3 bands are supported, and caller only expects allocator errors
        }
    }

    const ohms_display_len: usize = if (ohms >= 100 or @mod(ohms, 1) != 0) // ex "110" or "1.1"
        3
    else if (ohms >= 10) // ex: "11"
        2
    else // ex: "1"
        1;

    // count # chars in: "1.1" + " " + "kilo" + "ohms"
    const total_display_len = ohms_display_len + 1 + prefix.len + 4;
    const display_value_buffer = try allocator.alloc(u8, total_display_len);
    errdefer allocator.free(display_value_buffer);
    _ = std.fmt.bufPrint(display_value_buffer, "{d} {s}ohms", .{ ohms, prefix }) catch {
        // caller only expects allocator errors
        return mem.Allocator.Error.OutOfMemory;
    };
    std.debug.print("{s}\n", .{ display_value_buffer});
    return display_value_buffer;
}

fn getMetricPrefix(power_of_1000: usize) []const u8 {
    return switch (power_of_1000) {
        0 => "",
        1 => "kilo",
        2 => "mega",
        3 => "giga",
        4 => "tera",
        5 => "peta",
        6 => "exa",
        7 => "zetta",
        8 => "yotta",
        else => "????"
    };
}
