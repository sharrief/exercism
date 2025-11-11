pub fn eggCount(number: usize) usize {
    // bit shift until value has 0 bits
    const least_sig_bit: usize = 0x00_00_00_00_00_00_00_01;
    var curr_encoding = number;
    var total_eggs: usize = 0;
    while (curr_encoding > 0) {
       if ((least_sig_bit & curr_encoding) == 1) total_eggs += 1;
       curr_encoding = curr_encoding >> 1;
    }
    return total_eggs;
}
