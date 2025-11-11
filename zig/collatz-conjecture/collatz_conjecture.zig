const std = @import("std");
// Please implement the `ComputationError.IllegalArgument` error.
pub const ComputationError  = error{ 
    IllegalArgument,
    AccumulatorOverflow,
};

pub fn steps(number: usize) anyerror!usize {
    if (number < 1) return ComputationError.IllegalArgument;
    var curr = number;
    var num_steps: usize = 0;
    const MAX_INT = std.math.maxInt(usize);
    while (curr > 1) {
        if (curr % 2 == 0) {
            curr /= 2;
        } else {
            const space_till_overflow = MAX_INT - curr;
            if ((space_till_overflow - 1) / 3 < curr) 
                return ComputationError.AccumulatorOverflow;
            curr = (curr * 3) + 1;
        }
        num_steps += 1;
    }
    return num_steps;
}
