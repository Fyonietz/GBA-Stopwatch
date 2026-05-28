//Imports
const Video = @import("video.zig");
const Renderer = @import("renderer.zig");

//Constants
const SCREEN_BLOCK:u5 = 28;
const BACKGROUND_COLOR:u32 = 0x01020202;

//Functions
fn load_background_pallete() void{
    const background_pallete = [_]u16{
        Renderer.rgb_to_gba(0, 0 , 0), //Black
        Renderer.rgb_to_gba(31, 31 , 31),//White
        Renderer.rgb_to_gba(31, 0 , 0),//Red
    };
    for(background_pallete,0..) |c,i| {
        Video.BACKGROUND_PALLETE_REGISTER[i] = c;
    }
}
fn set_background_color(map_to_tile_data:[*]volatile u32,map_to_screen:[*]volatile u16,color:u32) void{
    var i:u32 = 0;
    while(i < 16):(i+=1){
        map_to_tile_data[i] = color;
    }
    i = 0;
    
    while(i < 32 * 32):(i+=1){
        map_to_screen[i] = 0;
    } 
}
export fn _start() noreturn{
    //Init 
    Video.DISPLAY_CONTROL.* = Video.DISPLAY_CONTROL_MODE_0 | Video.DISPLAY_CONTROL_BACKGROUND_0;
    const map_to_screen = Video.screen_block_ptr(SCREEN_BLOCK);
    const map_to_tile_data = @as([*]volatile u32,@ptrFromInt(Video.VRAM_ADDRESS)); 
    load_background_pallete();
    set_background_color(map_to_tile_data, map_to_screen, BACKGROUND_COLOR);
    Video.BACKGROUND_0_CONTROL.* = Video.background_control(0, 0, SCREEN_BLOCK, true);
    while (true) {
        Video.video_blank_start();


        Video.video_blank_end();
    }
}
