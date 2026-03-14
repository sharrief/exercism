// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, sortedItems: []const T) ?usize {
    if (sortedItems.len < 1) {
        return null;
    }

    var start: usize = 0;
    var end: usize = sortedItems.len - 1;

    while (start <= end) {
        const mid = start + ((end - start) / 2);
        const middleItem = sortedItems[mid];

        if (middleItem == target) {
            return mid;
        } else if (start == mid) {
            break;
        } else if (middleItem > target) {
            end = mid - 1;
        } else if (middleItem < target) {
            start = mid + 1;
        }
    }
    return null;
}
