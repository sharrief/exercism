const std = @import("std");

pub const Coordinate = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return .{
            .x = x_coord,
            .y = y_coord,
        };
    }
    pub fn score(self: Coordinate) usize {
        const x_sq = std.math.pow(f64, self.x, 2);
        const y_sq = std.math.pow(f64, self.y, 2);
        const dist_to_origin = std.math.sqrt(x_sq + y_sq);
        if (dist_to_origin <= 1) return 10;
        if (dist_to_origin <= 5) return 5;
        if (dist_to_origin <= 10) return 1;
        return 0;
    }
};
