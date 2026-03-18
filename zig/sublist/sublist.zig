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

const mem = @import("std").mem;

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (mem.eql(i32, list_one, list_two))
        return .equal;

    const larger, const smaller = if (list_one.len > list_two.len) .{ list_one, list_two } else .{ list_two, list_one };
    var window_end: usize = smaller.len;

    while (window_end <= larger.len) : (window_end += 1) {
        const window = larger[window_end - smaller.len .. window_end];
        if (mem.eql(i32, window, smaller))
            return if (larger.ptr == list_one.ptr) .superlist else .sublist;
    }
    return .unequal;
}
