/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    for (0..s.len) |i| {
        const reversedIndex = s.len - 1 - i;
        if (reversedIndex >= buffer.len) break;
        buffer[reversedIndex] = s[i];
    }
    return buffer[0..s.len];
}
