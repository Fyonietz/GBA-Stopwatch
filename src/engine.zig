const Video = @import("video.zig");
pub const Tile_Format = [7][2]u32;
pub const Object = struct {
    Id:u32 = 0,
    Tile:Tile_Format,
    Map:[*]volatile Video.Tile
};
