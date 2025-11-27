const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum(u8) {
    eggs = 0b1,
    peanuts = 0b10,
    shellfish = 0b100,
    strawberries = 0b1000,
    tomatoes = 0b10000,
    chocolate = 0b100000,
    pollen = 0b1000000,
    cats = 0b10000000,
};

fn debug(comptime fmt: []const u8, args: anytype) void {
    std.debug.print(fmt, args);
}
pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    const allergen_value = @intFromEnum(allergen);
    const score_contains_allergen: bool = (score & allergen_value) == allergen_value;
    debug(">>>\nisAllergicTo(score: {b:0>8}, allergen: {s} {b:0>8}) => {any}\n<<<\n", .{ score, @tagName(allergen), allergen_value, score_contains_allergen });
    return score_contains_allergen;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var allergens_in_score = std.EnumSet(Allergen).initEmpty();
    debug(">>>\ninitAllergenSet(score: {d})\n", .{score});
    debug("score in binary {b:0>8}\n", .{score});
    for (0..8) |allergen_bit_index| {
        const allergen_as_int = (@as(u8, 1) << @as(u3, @intCast(allergen_bit_index)));
        const allergen: Allergen = @enumFromInt(allergen_as_int);
        const allergen_name = @tagName(allergen);
        debug("--- bit {d} value {b:0>8} name {s}\n", .{ allergen_bit_index, allergen_as_int, allergen_name });

        const score_has_allergen: u8 = @intCast(score & allergen_as_int);
        if (score_has_allergen < 1) {
            continue;
        }

        allergens_in_score.insert(allergen);
    }
    var allergens_in_score_iterator = allergens_in_score.iterator();
    var i: usize = 0;
    while (allergens_in_score_iterator.next()) |allergen| {
        if (i > 0) debug(", ", .{});
        debug("{s}", .{@tagName(allergen)});
        i += 1;
    }
    debug("\n<<<\n", .{});
    return allergens_in_score;
}
