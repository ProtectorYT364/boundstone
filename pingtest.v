import vraklib
import net
import time

fn main() {
	address := '179.61.251.10:19132'
	rsaddr, rport := net.split_address(address) or { panic(err) } // ?
	rnet_addr := net.Addr{
		saddr: rsaddr
		port: rport
	}

	mut c := net.dial_udp('127.0.0.1:19133', address) or { panic(err) }
	defer {
		c.close() or { }
	}
	saddr, port := net.split_address('127.0.0.1:19133') or { panic(err) } // ?
	net_addr := net.Addr{
		saddr: saddr
		port: port
	}

	mut b :=[]byte{len: 33}
	mut ping := vraklib.UnConnectedPing{p:vraklib.new_packet(b, net_addr ),send_timestamp: vraklib.timestamp(), client_guid: u64(1)}
	ping.encode(mut ping.p.buffer)
	println('UnConnectedPing: "$ping"')
	println('Encoded "$ping.p.buffer"')
	c.write(ping.p.buffer.buffer) or { panic(err) }
	//rewind buffer
	ping.p.buffer.rewind()
	//ping.decode(mut b)
	//println('De-Encoded UnConnectedPing: "$ping"')
	//println('De-Encoded "$b.buffer.bytestr()"')

//	c.write(b.buffer) or { panic(err) }

	mut data := []byte{len: 1492}
	n, caddr := c.read(mut data) or { panic(err) }
	println('Got address $caddr')
	println('Got $n vs $data.len bytes: "$data.bytestr()"')
	//trim data
	data = data[..n]
	println('Got $n bytes: "$data.bytestr()"')

	//TODO read unconnected pong
	
	mut pong := vraklib.UnConnectedPong{p:vraklib.new_packet(data, rnet_addr )}
	pid := pong.p.buffer.get_byte()
	println(pid)
	pong.decode(mut pong.p.buffer)
	println(pong)
	title := pong.data.bytestr()
	println(title)
	mut pong_data := vraklib.PongData{}
	pong_data.from_string(title)
	println(pong_data)


	// defer {
	// 	c.close() or { panic(err) }
	// }
	c.close() or {
		 	println('Server: connection dropped')
		 	panic(err)
	}
}

// timestamp returns a timestamp in milliseconds.
fn timestamp() u64 {
	return time.now().unix_time_milli()
}
