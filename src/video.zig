pub const VRAM_ADDRESS:u32 = 0x06000000;
pub const SCREEN_WIDTH:u32 = 240;
pub const SCREEN_HEIGHT:u32 = 160;

//Display Control and Video Count

pub const DISPLAY_CONTROL = @as(*volatile u16,@ptrFromInt(0x04000000));
pub const VERTICAL_COUNTER = @as(*volatile u16,@ptrFromInt(0x04000006));

//Display Control Flags
pub const DISPLAY_CONTROL_MODE_0:u16 = 0x0000;
pub const DISPLAY_CONTROL_BACKGROUND_0:u16 = 1 << 8;
pub const DISPLAY_CONTROL_BACKGROUND_1:u16 = 1 << 9;
pub const DISPLAY_CONTROL_BACKGROUND_2:u16 = 1 << 10;
pub const DISPLAY_CONTROL_BACKGROUND_3:u16 = 1 << 11;

//Background Control Registers
pub const BACKGROUND_0_CONTROL = @as(*volatile u16,@ptrFromInt(0x04000008));
pub const BACKGROUND_1_CONTROL = @as(*volatile u16,@ptrFromInt(0x0400000A));
pub const BACKGROUND_2_CONTROL = @as(*volatile u16,@ptrFromInt(0x0400000C));
pub const BACKGROUND_3_CONTROL = @as(*volatile u16,@ptrFromInt(0x0400000E));

//RAM Pallete Register
pub const BACKGROUND_PALLETE_REGISTER = @as([*]volatile u16,@ptrFromInt(0x05000000));
pub const BACKGROUND_OBJECT_REGISTER = @as([*]volatile u16,@ptrFromInt(0x05000200));

//Video RAM Registe
pub const VRAM = @as(*volatile u16,@ptrFromInt(VRAM_ADDRESS));

//Compute or Mapping tile into character blocks
//Character block where the data is alive have 6 block with total 16kb
pub inline fn character_block_ptr(block:u2) [*]volatile u32{
    return @as([*]volatile u32,@ptrFromInt(VRAM_ADDRESS + @as(u32,block) * 0x4000 )); // 0x4000 = 16kb
}

//Compute screen block know as Tile Map the block start from 0-31 in 2kb Size
pub inline fn screen_block_ptr(block:u5) [*]volatile u16{
    return @as([*]volatile u16,@ptrFromInt(VRAM_ADDRESS + @as(u32,block) * 0x800 )); // 0x800 = 2kb
}


//Control the background
pub inline fn background_control(prior:u2,char_block:u2,screen_block:u5,is_256_color_pallete:bool) u16{
    return @as(u16,prior) | (@as(u16,char_block) << 2) | (@as(u16,screen_block) << 8) | 
        (if(is_256_color_pallete)(@as(u16,1 << 7)) else 0);
}

//Wait For Vblank
pub  fn video_blank_start() void{
    while(VERTICAL_COUNTER.* < 160) {}
}
pub  fn video_blank_end() void{
    while(VERTICAL_COUNTER.* >= 160) {}
}



