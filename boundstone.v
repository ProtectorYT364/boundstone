// import sync
import bstone
import vraklib
import term
import os
import net
import sync
import log

// mut running := true
// TODO: serversettings
fn main() {
	mut log := log.Log{}
	log.set_level(.debug)
	// Make a new file called server.log in the current folder
	log.set_full_logpath('./server.log')//TODO check if defer for save/close is needed

//TODO 29.03.2021 change println's to l.debug()

	// TODO spawn multiple threads https://github.com/vlang/v/blob/master/doc/docs.md#concurrency
	// mut threads := []thread{}
	// start terminal
	// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
	term.clear()
	// width, height := term.get_terminal_size()
	// term.hide_cursor()
	// term.set_cursor_position(x: 0, y: height)
	println(term.bg_black(term.red(term.bold('■ boundstone MCPE v0.0.1 ■'))))

	// TODO Data share between threads
	address := '0.0.0.0:19132'
	saddr, port := net.split_address(address) or { log.fatal(err) } // ?
	net_addr := net.Addr{
		saddr: saddr
		port: port
	}
	println(net_addr.str())
	mut raklib := vraklib.new_vraklib(net_addr) // TODO pass server config
	// threads <<
	go raklib.start()
	mut server := bstone.new_server(address: net_addr) // or { panic(err) }
	server.start() // todo put in threads
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
	// raklib.stop()
	server.stop()
	// threads.wait()
	println(term.warn_message('Stopped.'))
}