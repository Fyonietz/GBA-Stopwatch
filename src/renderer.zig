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

pub fn draw_pixel(obj:Engine.Object) void{
    // var block:u32 = 0;
    // while(block < 16):(block+=1){
    //     var column_counter:u5 = 0;
    //     if(block % 2 == 0){
    //         column_counter = 0 ;
    //         while(column_counter < 4) : (column_counter+=1){
    //             var row_counter:u5 = 0;
    //             while(row_counter < 7) : (row_counter+=1){
    //                 obj.Map[obj.Id][block] =  packed_byte(row_counter,column_counter,obj.Tile);
    //             }
    //         }
    //     }else{
    //
    //     }
    // }

    obj.Map[obj.Id][0]=reverse_endian(obj.Tile[0][0]);
    obj.Map[obj.Id][1]=reverse_endian(obj.Tile[0][1]);
}

//Target
//Jikalau Tile Genap Iterates Sampai 3,Jikaulau Tile Ganjil Iterates Mulai dari 3 Sampai 7
