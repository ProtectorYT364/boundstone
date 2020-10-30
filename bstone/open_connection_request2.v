module bstone

import vraklib

struct OpenConnectionRequest2 {
mut:
    p vraklib.Packet

    security bool
    cookie int
    rport u16
    mtu_size u16
    client_id u64
}

fn (mut r OpenConnectionRequest2) encode() {}

fn (mut r OpenConnectionRequest2) decode() {
    r.p.buffer.get_byte() // Packet ID
    r.security = r.p.buffer.get_bool()
    r.cookie = r.p.buffer.get_int()
    r.rport = r.p.buffer.get_ushort()
    r.mtu_size = r.p.buffer.get_ushort()
    r.client_id = r.p.buffer.get_ulong()
}
