module bstone

import net
import log
import term
import time

pub struct Server {
pub mut:
	//config shared &ServerConfig
	config shared ServerConfig
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

pub fn new_server(shared config ServerConfig) &Server {
	//sm := &Server{config, map[string]Player{}}
	sm := &Server{config: config}
	return sm
}

pub fn (mut s Server) start(shared logger Log) {
	println('Server thread starting')
	for !s.config.shutdown{

	}
}

pub fn (mut s Server) stop() {
	//s.config.shutdown = true
	println('Server thread stopping')}

/* pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
} */