import vraklib
import net
import time

fn main() {
	l := net.listen_udp(19132) or { panic(err) }
	echo_server(l)
}

fn echo_server(_c net.UdpConn) {
	mut c := _c
	for {
		mut buf := []byte{len: 1000, init: 0}
		n, addr := c.read(mut buf) or { continue }
		if n > 0{
			//c.close() or { panic(err) }
		}
		//c.close()
		println('Got address $addr')
		println('Got $n vs $buf.len bytes: "$buf.bytestr()"')
		// trim data
		buf = buf[..n]
		println('Got $n bytes: "$buf.bytestr()"')
		mut b := vraklib.new_bytebuffer(buf, u32(n))
		pid := b.get_byte()
		println(pid)
		mut ping := vraklib.UnConnectedPing{}
		println(ping)
		ping.decode(mut b)
		println(ping)
		println(b.buffer.bytestr())
		title := 'MCPE;PocketMine-MP Server;422;1.16.200;0;20;6110147563508788599;PocketMine-MP;Creative;'
		len := 35 + title.len
		buf = []byte{len: len, init: 0}
		mut pong := vraklib.UnConnectedPong{
			p: vraklib.new_packet(buf, u32(len))
			server_guid: 6110147563508788599
			send_timestamp: ping.send_timestamp
			// send_timestamp: timestamp()
			data: title.bytes()
		}
		// packet.buffer.reset()
		pong.encode(mut pong.p.buffer)
		buf = pong.p.buffer.buffer
		println(buf)
		println(addr.str())
		// c.write(buf) or {
		//  	println('Server: connection dropped')
		//  	println(err)
		//  	return
		// }

	mut r := net.dial_udp('127.0.0.1:19133', addr.str())  or { panic(err) }
	defer {
		c.close() or { panic(err) }
	}
	r.write(buf) or { panic(err) }
	r.close() or {
		 	println('Server: connection dropped')
		 	panic(err)
		}
	}
}

// timestamp returns a timestamp in milliseconds.
fn timestamp() u64 {
	return time.now().unix_time_milli()
}
