const unicode = @import("std").unicode;
pub fn truncate(phrase: []const u8) []const u8 {
    // use the utf8 byte seq length function to skip over codepoints
    // until reaching the 5th, at which point return a truncated slice of the input
    var byte_index: usize = 0;
    var codepoints: usize = 0;
    while (codepoints < 5 and byte_index < phrase.len) {
        const codepoint_len = unicode.utf8ByteSequenceLength(phrase[byte_index]) catch {
            break;
        };
        codepoints += 1;
        byte_index += codepoint_len;
    }
    return phrase[0..byte_index];
}
