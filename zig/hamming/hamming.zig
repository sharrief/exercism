const std = @import("std");

pub const DnaError = error{
    EmptyDnaStrands,
    UnequalDnaStrands,
};

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len < 1 or second.len < 1) return DnaError.EmptyDnaStrands;
    if (first.len != second.len) return DnaError.UnequalDnaStrands;
    var hamming_distance: usize = 0;
    for(first, second) |a,b| {
        if (a != b) hamming_distance += 1;
    }
    return hamming_distance;
}
