module bstone

import net

pub struct ServerConfig {
pub mut:
	address     net.Addr
	max_players int = 100
	name        string = 'boundstone MCPE'
}

pub struct Server {
pub mut:
	config  ServerConfig
	players map[string]Player
}

pub fn new_server(config ServerConfig) &Server {
	sm := &Server{config, map[string]Player{}}
	return sm
}

pub fn (mut s Server) start() {
	println('Server thread starting')
}

pub fn (mut s Server) stop() {
	println('Server thread stopping')
}

pub fn (mut s Server) add_player(player Player) {
	s.players[player.hash_code().str()] = player
}
