import bstone
import vraklib
//import sync
import term
import os
import net

// mut running := true
// TODO: serversettings
fn main(){
// Data share
// channel or sth here
//ch1 := chan vraklib.OpenSessionData{}
//ch2 := chan vraklib.HandleEncapsulatedData{}
//ch3 := chan vraklib.PutPacketData{}
// raklib = vraklib.VRakLib { address: address }

address := '0.0.0.0:19132'
saddr, port := net.split_address(address) //?
net_addr := net.Addr{saddr: saddr, port: port}

mut server := bstone.new_server(address: net_addr)// or { panic(err) }

mut raklib := &vraklib.VRakLib{
	port: port
}
//go raklib.start(ch1, ch2, ch3)
go raklib.start(net_addr)
server.start()
// start terminal
// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
term.clear()
// width, height := term.get_terminal_size()
// term.hide_cursor()
// term.set_cursor_position(x: 0, y: height)
println(term.bg_black(term.red(term.bold('■ boundstone MCPE v0.0.1 ■'))))
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
raklib.stop()
server.stop()
}