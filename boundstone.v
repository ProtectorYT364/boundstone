// import sync
import bstone
import vraklib
import term
import os
import net
import sync

// mut running := true
// TODO: serversettings
fn main() {
	//mut threads := []thread{}
	// start terminal
	// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
	term.clear()
	// width, height := term.get_terminal_size()
	// term.hide_cursor()
	// term.set_cursor_position(x: 0, y: height)
	println(term.bg_black(term.red(term.bold('■ boundstone MCPE v0.0.1 ■'))))

	// Data share
	// channel or sth here
	ch1 := chan vraklib.OpenSessionData{}
	ch2 := chan vraklib.HandleEncapsulatedData{}
	ch3 := chan vraklib.PutPacketData{}
	// raklib = vraklib.VRakLib { address: address }
	address := '127.0.0.1:19132'
	saddr, port := net.split_address(address) or { panic(err) } // ?
	net_addr := net.Addr{
		saddr: saddr
		port: port
	}
	println(net_addr.str())
	mut raklib := vraklib.new_vraklib(net_addr)
	/*threads <<*/ go raklib.start(ch1, ch2, ch3)
	mut server := bstone.new_server(address: net_addr) // or { panic(err) }
	server.start()//todo put in threads
	// go raklib.start(ch1, ch2, ch3)
	println(term.bg_black(term.green('Use "stop" for shutdown')))
	// TODO dynamic version string
	mut read_line := os.input('> ')
	for {
		if read_line == 'stop' {
			break
		} else {
			read_line = os.input('> ')
		}
	}
	println(term.warn_message('Shutting down..'))
	//raklib.stop()
	server.stop()
	//threads.wait()
	println(term.warn_message('Stopped.'))
}
