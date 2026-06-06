const Video = @import("video.zig");

pub const Object = struct {
    Id:u32 = 0,
    Tile:[7][8]u8,
    Map:[*]volatile Video.Tile
};
