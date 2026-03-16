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
const unicode = std.unicode;
const panic = std.debug.panic;

pub fn truncate(phrase: []const u8) []const u8 {
    // use the utf8 byte seq length function to skip over codepoints
    // until reaching the 5th, at which point return a truncated slice of the input
    var byte_index: usize = 0;
    var codepoints: usize = 0;
    while (codepoints < 5 and byte_index < phrase.len) {
        const codepoint_len = unicode.utf8ByteSequenceLength(phrase[byte_index]) catch |err| {
            panic("Error while truncating: {}", .{err});
        };
        codepoints += 1;
        byte_index += codepoint_len;
    }
    return phrase[0..byte_index];
}
