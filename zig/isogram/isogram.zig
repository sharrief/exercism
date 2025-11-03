pub fn isIsogram(str: []const u8) bool {
    // There are 256 different utf-8 chars represented by u8
    var charsSeen: u256 = 0;
    for (str) |char| {
        var charIndex: u8 = char;
        if (65 <= char and char <= 90) {
            // map uppercase letter to lowercase
            charIndex += 32;
        } else if (char < 97 or 122 < char) { 
            // char is not upper or lower case letter
            continue;
        }
        // Check if the bit corresponding to the charIndex 
        // has been already been set, meaning the letter (case insensitive) has been seen
        if ((charsSeen & (@as(u256, 1) << charIndex)) != 0) return false;
        // Set the bit to 1 indicating this letter has been seen
        charsSeen |= (@as(u256, 1) << charIndex);
    }
    return true;
}
