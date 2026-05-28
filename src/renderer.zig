
pub inline fn rgb_to_gba(r:u5,g:u5,b:u5) u16{
    return @as(u16,r) | (@as(u16,g ) << 5) | (@as(u16,b) << 10);
}
