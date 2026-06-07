const Video = @import("video.zig");
const Engine = @import("engine.zig");

pub inline fn rgb_to_gba(r:u5,g:u5,b:u5) u16{
    return @as(u16,r) | (@as(u16,g ) << 5) | (@as(u16,b) << 10);
}

fn reverse_endian(data:anytype) u32{
    return (@as(u32,data & 0x000000FF) << 24) |
           (@as(u32,data & 0x0000FF00) << 8) |
           (@as(u32,data & 0x00FF0000) >> 8) |
           (@as(u32,data & 0xFF000000) >> 24);
}

pub fn draw_pixel(obj: Engine.Object) void {
    var block: u32 = 0;

    while (block < 16) : (block += 1) {
        const row = block / 2;
        const col = block % 2;
        if(row < 7){
            obj.Map[obj.Id][block] = reverse_endian(obj.Tile[row][col]);
        }
    }
}   
