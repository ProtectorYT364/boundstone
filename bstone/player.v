module bstone

import vraklib

struct Player {
    vraklib VRakLib

    server Server
    ip string
    port u16
}

pub fn new_player(vraklib VRakLib, server Server, ip string, port u16) Player {
    return Player {
        vraklib: vraklib
        server: server
        ip: ip
        port: port
    }
}

fn (p Player) handle_data_packet(packet vraklib.Packet) {//TODO uhm.. shouldn't these be split?
    
}

fn (p Player) hash_code() int {
    return 0
}