module bstone

import net
import log
import term
import time

pub struct Server {
pub mut:
	//config shared &ServerConfig
	config shared ServerConfig
	logger shared Log
	//players map[string]Player
}

pub struct ServerConfig {//TODO replace with config
pub:
	addr net.Addr
pub mut:
	max_players int = 100
	name        string = 'boundstone MCPE'
	shutdown bool = false
}

pub fn new_server(shared config ServerConfig, shared logger Log) &Server {
	//sm := &Server{config, map[string]Player{}}
	sm := &Server{config: config, logger: logger}
	return sm
}

pub fn (mut s Server) start() {
	s.logger().log('Server thread starting',.debug)
	for !s.config.shutdown{

	}
}

pub fn (mut s Server) stop() {
	//s.config.shutdown = true
	s.logger().log('Server thread stopping',.debug)
	}

/* pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
} */

pub fn(s Server) logger() shared Log{
	return s.logger
}