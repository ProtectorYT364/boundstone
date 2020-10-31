module bstone

pub struct Server {
pub:
    port int = 19132
    number_of_players int = 100
    name string

pub mut:
    players map[string]Player
}

pub fn (mut s Server) start() {

}

pub fn (mut s Server) stop() {
}

pub fn (mut s Server) add_player(player Player) {
    s.players[player.hash_code().str()] = player
}