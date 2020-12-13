import bstone
import vraklib
import sync
import term
import os

// import net
// mut running := true
// TODO: serversettings
port := 19132
// Threads
mut server := bstone.Server{
	name: 'Testserver'
}
mut raklib := &vraklib.VRakLib{
	port: port
}
// Data share
// channel or sth here
ch1 := chan vraklib.OpenSessionData{}
ch2 := chan vraklib.HandleEncapsulatedData{}
ch3 := chan vraklib.PutPacketData{}
// raklib = vraklib.VRakLib { address: address }
go raklib.start(ch1, ch2, ch3)
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
