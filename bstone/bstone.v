module bstone

import net
import log

pub struct ServerConfig {
pub mut:
	addr net.Addr
	l chan LogMsg
	max_players int = 100
	name        string = 'boundstone MCPE'
}

pub struct LogMsg{
//pub:
pub mut:
	m string
	l log.Level
}

/* pub fn new_server(config ServerConfig) &Server {
	//sm := &Server{config, map[string]Player{}}
	sm := &Server{config}
	return sm
} */

/* pub fn (mut s Server) start() {
	println('Server thread starting')
}

pub fn (mut s Server) stop() {
	println('Server thread stopping')
}

pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
} */

pub fn(c ServerConfig) log(m string, l log.Level){
	c.l <- LogMsg{m,l}
}