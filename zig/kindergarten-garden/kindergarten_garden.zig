// Communicate intent precisely.
// Edge cases matter.
// Favor reading code over writing code.
// Only one obvious way to do things.
// Runtime crashes are better than bugs.
// Compile errors are better than runtime crashes.
// Incremental improvements.
// Avoid local maximums.
// Reduce the amount one must remember.
// Focus on code rather than style.
// Resource allocation may fail; resource deallocation must succeed.
// Memory is a resource.
// Together we serve the users.
const split = @import("std").mem.splitSequence;
const panic = @import("std").debug.panic;

pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    // student names are unique and are sorted alphabetically without gaps
    // so normalize the student name to a 0-based index
    // which locates the student's plants in the diagram
    if (student[0] < 'A' or 'Z' < student[0]) {
        panic("student \"{s}\" did not begin with an ascii uppercase letter\n", .{student});
    }

    const student_index = student[0] - 'A';
    const first_plant_index = student_index * 2;
    const second_plant_index = student_index * 2 + 1;

    var plant_row_iterator = split(u8, diagram, "\n");
    const first_plant_row = plant_row_iterator.next() orelse panic("diagram \"{s}\" missing a first row of plants\n", .{diagram});
    const second_plant_row = plant_row_iterator.next() orelse panic("diagram \"{s}\" missing a second row of plants\n", .{diagram});

    return .{
        getPlantFromFirstLetterInName(first_plant_row[first_plant_index]),
        getPlantFromFirstLetterInName(first_plant_row[second_plant_index]),
        getPlantFromFirstLetterInName(second_plant_row[first_plant_index]),
        getPlantFromFirstLetterInName(second_plant_row[second_plant_index]),
    };
}

fn getPlantFromFirstLetterInName(char: u8) Plant {
    return switch (char) {
        'C' => .clover,
        'G' => .grass,
        'R' => .radishes,
        'V' => .violets,
        else => panic("no plant name starting with '{c}'\n", .{char}),
    };
}
