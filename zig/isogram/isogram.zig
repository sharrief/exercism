pub fn isIsogram(str: []const u8) bool {
    // There are 256 different chars represented by u8
    var charsSeen: u256 = 0;
    for (str) |char| {
        var charIndex: u8 = 0;
        // Index the utf-8 value of letter characters to 0
        if (97 <= char and char <= 122) {
            // 'a' goes from 97 to 0, 'z' from 122 to 25
            charIndex = char - 97;
        } else if (65 <= char and char <= 90) {
            // 'A' goes from 65 to 0, 'Z' from 90 to '25'
            charIndex = char - 65;
        } else { 
            // ignore other characters
            continue;
        }
        // Check if the bit corresponding to the charIndex 
        // has been already been set, meaning the letter (case insensitive) has been seend
        if ((charsSeen & (@as(u256, 1) << charIndex)) != 0) return false;
        // Set the bit to 1 indicating this letter has been seen
        charsSeen |= (@as(u256, 1) << charIndex);
    }
    return true;
}
