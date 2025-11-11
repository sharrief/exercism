const std = @import("std");

pub const HighScores = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    top_3: [3]i32,
    num_scores: usize,
    last: ?i32,

    pub fn init(scores: []const i32) HighScores {
        var top_3 = [3]i32{0, 0, 0};
        const num_scores = if (scores.len >= 3) 3 else scores.len;
        var last: ?i32 = null;

        for (scores) |score| {
            var new_top_3 = top_3;
            if (score >= top_3[0]) {
                new_top_3 = .{ score, top_3[0], top_3[1] };
            } else if (score >= top_3[1]) {
                new_top_3 = .{ top_3[0], score, top_3[1] };
            } else if (score >= top_3[2]) {
                new_top_3 = .{ top_3[0], top_3[1], score };
            }
            top_3 = new_top_3;
            last = score;
        }
        std.debug.print("top_3 {any}. count {d}\n", .{ top_3[0..], num_scores });
        return .{ .top_3 = top_3, .num_scores = num_scores, .last = last };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.last;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.num_scores > 0) return self.top_3[0];
        return null;
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top_3[0..self.num_scores];
    }
};

