module bstone

import net
import log
import term
import time

pub struct Server {
pub mut:
	config  &ServerConfig
	//players map[string]Player
}

pub struct ServerConfig {
pub:
	addr net.Addr
pub mut:
	max_players int = 100
	name        string = 'boundstone MCPE'
	shutdown bool = false
}

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