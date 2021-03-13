import vraklib
import net
import time

fn main() {
	address := '179.61.251.10:19132'


	mut c := net.dial_tcp(address) ?
	defer {
		c.close() or { }
	}

	mut fuckoff := []byte{len: 1024}
	mut b := vraklib.new_bytebuffer(fuckoff, u32(1024))
	mut ping := vraklib.UnConnectedPing{send_timestamp: timestamp(), client_guid: u64(1)}
	ping.encode(mut b)
	println('Encoded "$b.buffer.bytestr()"')

	mut data := b.buffer
	c.write(data) ?
	mut buf := []byte{len: 1492}
	n := c.read(mut buf) ?
	println('Got "$buf.bytestr()"')
	data = data[..n]

	//TODO read unconnected pong
}

// timestamp returns a timestamp in milliseconds.
fn timestamp() u64 {
	return time.now().unix_time_milli()
}