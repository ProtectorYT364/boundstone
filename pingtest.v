import vraklib
import net
import time

fn main() {
	address := '0.0.0.0:19132'

	mut c := net.dial_udp('127.0.0.1:40003', address) or { panic(err) }
	defer {
		c.close() or { }
	}

	mut fuckoff := []byte{len: 33}
	mut b := vraklib.new_bytebuffer(fuckoff, u32(33))
	mut ping := vraklib.UnConnectedPing{send_timestamp: vraklib.timestamp(), client_guid: u64(1)}
	ping.encode(mut b)
	println('UnConnectedPing: "$ping"')
	println('Encoded "$b.buffer.bytestr()"')
	//rewind buffer
	b.position = 0
	//ping.decode(mut b)
	//println('De-Encoded UnConnectedPing: "$ping"')
	//println('De-Encoded "$b.buffer.bytestr()"')

	c.write(b.buffer) or { panic(err) }

	mut data := []byte{len: 1492}
	n, addr := c.read(mut data) or { panic(err) }
	println('Got address $addr')
	println('Got $n vs $data.len bytes: "$data.bytestr()"')
	//trim data
	data = data[..n]
	println('Got $n bytes: "$data.bytestr()"')

	//TODO read unconnected pong
	b.position = 0
	b.buffer = data
	b.length = u32(b.buffer.len)
	
	pid := b.get_byte()
	println(pid)
	mut pong := vraklib.UnConnectedPong{}
	println(pong)
	pong.decode(mut b)
	println(pong)
	println(pong.data.bytestr())

	c.close() or { panic(err) }
}

// timestamp returns a timestamp in milliseconds.
fn timestamp() u64 {
	return time.now().unix_time_milli()
}
