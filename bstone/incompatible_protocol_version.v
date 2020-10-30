module bstone

import vraklib

struct IncompatibleProtocolVersion {
mut:
    p vraklib.Packet

    version byte
    server_id i64
}

fn (mut r IncompatibleProtocolVersion) encode() {
    r.p.buffer.put_byte(IdIncompatibleProtocolVersion)
    r.p.buffer.put_byte(r.version)
    r.p.buffer.put_bytes(get_packet_magic().data, RaknetMagicLength)
    r.p.buffer.put_long(r.server_id)
}

fn (r IncompatibleProtocolVersion) decode() {}
