pub fn isPangram(str: []const u8) bool {
    var lettersUsed: u256 = 0;
    for (str) |char| {
        var letter = char;
        if ('A' <= char and char <= 'Z') {
            // convert upper case letters to lower case
            letter += 'a' - 'A';
        }
        if ('a' <= letter and letter <= 'z') {
            // is lower case letter
            // set flag so we know this letter was seen
            lettersUsed |= (@as(u256, 1) << letter);
        }
    }
    var allLetters: u256 = 0;
    for ('a'..'z' + 1) |i| {
        const letter: u8 = @intCast(i);
        allLetters |= (@as(u256, 1) << letter);
    }
    return lettersUsed == allLetters; 
}
