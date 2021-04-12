module bstone

import logger

pub struct Server {
pub mut:
	settings shared Settings
	run bool
	// players map[string]Player
}

pub fn new_server(shared s Settings) &Server {
	// sm := &Server{settings, map[string]Player{}}
	sm := &Server{
		settings: s
	}
	return sm
}

pub fn (mut s Server) start() {
	logger.log('Server thread starting', .debug)
	for !s.run {
	}
	logger.log('Server thread stopping', .debug)
}

pub fn (mut s Server) stop() {
	logger.log('Server thread stopping', .debug)
}

/*
pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
}*/
