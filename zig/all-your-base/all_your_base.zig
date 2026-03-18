// * Communicate intent precisely.
// * Edge cases matter.
// * Favor reading code over writing code.
// * Only one obvious way to do things.
// * Runtime crashes are better than bugs.
// * Compile errors are better than runtime crashes.
// * Incremental improvements.
// * Avoid local maximums.
// * Reduce the amount one must remember.
// * Focus on code rather than style.
// * Resource allocation may fail; resource deallocation must succeed.
// * Memory is a resource.
// * Together we serve the users.

const std = @import("std");
const mem = std.mem;
const math = std.math;
const ArrayList = std.ArrayList;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

const PositionalNotation = struct {
    digits: []u32,
    base: u32,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    const input_digits = try allocator.alloc(u32, digits.len);
    defer allocator.free(input_digits);
    @memcpy(input_digits, digits);
    const input_notation = PositionalNotation{
        .digits = input_digits,
        .base = input_base,
    };

    const number = try composeNumberFromPositionalNotation(input_notation);
    const output_notation = try decomposeNumberToPositionalNotation(allocator, number, output_base);

    return output_notation.digits;
}

fn composeNumberFromPositionalNotation(notation: PositionalNotation) ConversionError!u32 {
    const digits = notation.digits;
    const base = notation.base;
    var number: u32 = 0;
    for (0..digits.len) |i| {
        const digit = digits[i];
        if (digit >= base) return ConversionError.InvalidDigit;
        const power = digits.len - i - 1;
        number += digit * math.pow(u32, base, @intCast(power));
    }
    return number;
}

fn decomposeNumberToPositionalNotation(allocator: mem.Allocator, number: u32, base: u32) (mem.Allocator.Error || ConversionError)!PositionalNotation {
    // 42    =    4     *   10 ^ 1  +   2   *   10 ^ 0
    // ^^--number ^--digit  ^^^^^^--place value
    // 1. find the largest power of the base that is less than the number, this is the larget place value
    // 2. calculate how many times that place value divides wholly in to the number, this is the digit for that place value
    // 3. calculate the remainder after dividing the place value into the number, this remainder is the new number
    // 4. repeat 1-3 through power 0
    // append the digits to an array list along the way
    var digits = try ArrayList(u32).initCapacity(allocator, 0);
    defer digits.deinit(allocator);

    if (number < 1) {
        try digits.append(allocator, 0);
        return .{ .digits = try digits.toOwnedSlice(allocator), .base = base };
    }

    var remainder = number;
    var power = math.log(u32, base, remainder);
    while (power >= 0) : (power -= 1) {
        const place_value = math.pow(u32, base, power);
        const digit = math.divFloor(u32, remainder, place_value) catch {
            return ConversionError.InvalidOutputBase;
        };

        remainder -= digit * place_value;
        try digits.append(allocator, digit);
        if (power == 0) break;
    }
    return .{ .digits = try digits.toOwnedSlice(allocator), .base = base };
}
