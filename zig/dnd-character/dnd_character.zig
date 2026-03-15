const std = @import("std");

var prng: std.Random.DefaultPrng = .init(1);
const random = prng.random();

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    const dice = [_]i8{
        random.intRangeAtMost(i8, 1, 6),
        random.intRangeAtMost(i8, 1, 6),
        random.intRangeAtMost(i8, 1, 6),
        random.intRangeAtMost(i8, 1, 6),
    };

    var sum_of_largest_three: i8 = 0;
    var min: i8 = std.math.maxInt(i8);
    var die_count: u8 = 0;

    for (dice) |die| {
        if (die_count < 3) {
            sum_of_largest_three += die;
        } else if (die < min) {
            break;
        } else {
            sum_of_largest_three -= min;
            sum_of_largest_three += die;
        }

        if (die < min) {
            min = die;
        }

        die_count += 1;
    }
    return sum_of_largest_three;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constituion = ability();
        return .{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constituion,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constituion),
        };
    }
};
