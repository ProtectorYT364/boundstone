module bstone

import vraklib

struct ConnectionRequest {
mut:
    p vraklib.Packet

    client_id i64
    ping_time i64
    use_security bool
}

fn (mut r ConnectionRequest) encode() {}

fn (mut r ConnectionRequest) decode() {
    r.p.buffer.get_byte()
    r.client_id = r.p.buffer.get_long()
    r.ping_time = r.p.buffer.get_long()
    r.use_security = r.p.buffer.get_bool()
}
