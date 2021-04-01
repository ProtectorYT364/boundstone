module bstone

import net
import log
import term
import time

pub struct Server {
pub mut:
	config  ServerConfig
	shutdown bool = false
	//players map[string]Player
}

pub struct ServerConfig {
pub mut:
	addr net.Addr
	max_players int = 100
	name        string = 'boundstone MCPE'
/* pub:
	l chan LogMsg */
}/* 

pub struct LogMsg{
//pub:
pub mut:
	m string
	l log.Level = .debug
} */

pub fn new_server(config ServerConfig) &Server {
	//sm := &Server{config, map[string]Player{}}
	sm := &Server{config: config}
	return sm
}

pub fn (mut s Server) start(shared logger Log) {
	println('Server thread starting')
	for !s.shutdown{

	}
}

pub fn (mut s Server) stop() {
	s.shutdown = true
	println('Server thread stopping')
	println('Shutdown server? $s.shutdown')
}

/* pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
} */