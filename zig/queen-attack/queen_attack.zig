pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (0 > row or row > 7 or 0 > col or col > 7) {
            return QueenError.InitializationFailure;
        }
        return .{ .row = row, .col = col };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        const onSameRow = self.row == other.row;
        const onSameCol = self.col == other.col;
        const onSameDiagTopLefBottomRight = (self.row - self.col) == (other.row - other.col);
        const onSameDiagTopRightBottomLeft = (self.row + self.col) == (other.row + other.col);

        return onSameRow or onSameCol or onSameDiagTopLefBottomRight or onSameDiagTopRightBottomLeft;
    }
};
