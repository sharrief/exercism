const std = @import("std");
const mem = std.mem;

const AnagramError = error{ InvalidCharacter, OutOfMemory };
/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) AnagramError!std.BufSet {
    var anagrams = std.BufSet.init(allocator);
    // free the memory if an error occurs, else we return the allocated memory to the caller
    errdefer anagrams.deinit();
    if (word.len == 0 or candidates.len == 0) {
        return anagrams;
    }
    // create an array [26]u8 tracking frequency of chars in word
    // assuming no character appears more than 255 times in any word
    var charFrequencyInWord = [_]u8{0} ** 26;
    for (word) |char| {
        // use helper to normalize characters to indexes:  'A' --> 0
        const charIndex = try getIndexOfCharInAlphabet(char);
        charFrequencyInWord[charIndex] += 1;
    }
    // create an array [26]u8 tracking frequency of chars in a candidate
    var charFrequencyInCandidate: [26]u8 = undefined;
    candidateLoop: for (candidates) |candidate| {
        // clear the frequncy array for this candidate
        charFrequencyInCandidate = .{0} ** 26;
        if (candidate.len != word.len) continue;

        // if the candidate is the same word just with diff casing then its not an anagram
        var sameCharacterAtAllIndicies = true;

        for (candidate, word) |candidateChar, wordChar| {
            const charIndex = try getIndexOfCharInAlphabet(candidateChar);
            const wordCharIndex = try getIndexOfCharInAlphabet(wordChar);

            // if the candidate is the same word then this will never be set to false
            if (wordCharIndex != charIndex) {
                sameCharacterAtAllIndicies = false;
            }

            // if the char doesn't appear in the word it can't be an anagram, continue to next candidate
            if (charFrequencyInWord[charIndex] < 1) {
                continue :candidateLoop;
            }

            // if a character appears more often in the candidate, then it cannot be an anagram
            charFrequencyInCandidate[charIndex] += 1;
            if (charFrequencyInCandidate[charIndex] > charFrequencyInWord[charIndex]) {
                continue :candidateLoop;
            }
        }
        if (!sameCharacterAtAllIndicies) {
            // the candidate has the same character frequency as the word,
            // and the characters are in different places, so its an anagram
            try anagrams.insert(candidate);
        }
    }
    return anagrams;
}

/// Normalizes ASCII characters so that 'A' and 'a' are 0
fn getIndexOfCharInAlphabet(char: u8) AnagramError!u8 {
    if ('A' <= char and char <= 'Z') {
        return char - 'A';
    } else if ('a' <= char and char <= 'z') {
        return char - 'a';
    }
    return error.InvalidCharacter;
}
