module bstone

import vraklib

struct OpenConnectionRequest1 {
mut:
    p vraklib.Packet

    version byte
    mtu_size u16
}

fn (mut r OpenConnectionRequest1) encode() {}

fn (mut r OpenConnectionRequest1) decode() {
    r.p.buffer.get_byte() // Packet ID
    r.p.buffer.get_bytes(RaknetMagicLength)
    r.version = r.p.buffer.get_byte()
    r.mtu_size = u16(r.p.buffer.length - r.p.buffer.position)
}
