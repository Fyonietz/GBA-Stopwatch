const Video = @import("video.zig");
const Engine = @import("engine.zig");

pub inline fn rgb_to_gba(r:u5,g:u5,b:u5) u16{
    return @as(u16,r) | (@as(u16,g ) << 5) | (@as(u16,b) << 10);
}

fn packed_byte(counter:u5,arg:u8)u32{
    if(counter == 0){
        return (@as(u32,arg));
    }
    if(counter == 1){
        return (@as(u32,arg) << 8);
    }
    if(counter == 2){
        return (@as(u32,arg) << 16);
    }
    if(counter == 3){
        return (@as(u32,arg) << 24);
    }

    return 0 ;
}

pub fn draw_pixel(obj:Engine.Object) void{
    var block:u32 = 0;
    while(block < 16):(block+=1){
        var column_counter:u5 = 0;
        if(block % 2 == 0){
            column_counter = 0 ;
            while(column_counter < 4) : (column_counter+=1){
                var row_counter:u5 = 0;
                while(row_counter < 7) : (row_counter+=1){
                    obj.Map[obj.Id][block] =  packed_byte(column_counter,obj.Tile[row_counter][column_counter]);
                }
            }
        }else{

        }
    }
}

//Target
//Jikalau Tile Genap Iterates Sampai 3,Jikaulau Tile Ganjil Iterates Mulai dari 3 Sampai 7
