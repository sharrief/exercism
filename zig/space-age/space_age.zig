const std = @import("std");

pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const earth_year_in_seconds: f64 = @as(f64, @floatFromInt(seconds)) / (365.25 * 24.0 * 60.0 * 60.0);
        const earth_year_per_planet_year: f64 = switch (self) {
            .mercury => 0.2408467,
            .venus => 0.61519726,
            .earth => 1,
            .mars => 1.8808158,
            .jupiter => 11.862615,
            .saturn => 29.447498,
            .uranus => 84.016846,
            .neptune => 164.79132,
        };
        const planet_years = earth_year_in_seconds / earth_year_per_planet_year;
        std.debug.print("{any}: {d}\n", .{self, planet_years});
        return planet_years;
    }
};
