const Video = @import("video.zig");
const Engine = @import("engine.zig");
pub const Data =  struct {
 pub const Number_0:Engine.Tile_Format =.{
        .{0x03_03_01_01, 0x04_04_03_03},
        .{0x00_00_03_03, 0x4_04_00_00},
        .{0x00_00_03_03, 0x4_04_00_00},
        .{0x00_00_03_03, 0x4_04_00_00},
        .{0x00_00_03_03, 0x4_04_00_00},
        .{0x00_00_03_03, 0x4_04_00_00},
        .{0x00_00_03_03, 0x4_04_00_00},
    };
 pub fn load_font(map_to_tile_data:[*]volatile Video.Tile,font:[1][8]u8,tile_id:u32) void{
    // var block:u5 = 0;
    //  while(block < 16):(block+=1){
    //     var font_row :u5 = 0;
    //     if(block % 2 != 0){
    //         while(font_row <= 6 ):(font_row+=1){
    //             // map_to_tile_data[tile_id][block] = font[font_row][0];
    //         }
    //     }
    //     while(font_row <= 6 ):(font_row+=1){
    //         map_to_tile_data[tile_id][block] = font[font_row][1];
    //     }
    //
    // }
    map_to_tile_data[tile_id][0] = font[0][0];
}
};
//Block Even Index Is Left Side 
//Block Odd Index Is Right Side 
