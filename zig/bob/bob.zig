const std = @import("std");

pub fn response(prompt: []const u8) []const u8 {
    var isSilence = true;
    var containsUppercaseCharacters = false;
    var containsLowercaseCharacters = false;
    var endsWithQuestionMark = false;

    for (prompt) |char| {
        if (std.ascii.isWhitespace(char)) {
            continue;
        }
        isSilence = false;
        if (std.ascii.isLower(char)) {
            containsLowercaseCharacters = true;
        } else if (std.ascii.isUpper(char)) {
            containsUppercaseCharacters = true;
        }
        if ('?' == char) {
            endsWithQuestionMark = true;
        } else {
            endsWithQuestionMark = false;
        }
    }

    if (isSilence) {
        return "Fine. Be that way!";
    } else if (containsUppercaseCharacters and !containsLowercaseCharacters and endsWithQuestionMark) {
        return "Calm down, I know what I'm doing!";
    } else if (containsUppercaseCharacters and !containsLowercaseCharacters) {
        return "Whoa, chill out!";
    } else if (endsWithQuestionMark) {
        return "Sure.";
    }
    return "Whatever.";
}
