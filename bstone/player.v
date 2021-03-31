module bstone

//import vraklib

struct Player {
//	vraklib vraklib.VRakLib
//	server  Server
	ip      string
	port    u16
}

//pub fn(mut s Server) new_player(ip string, port u16) Player {
pub fn new_player(ip string, port u16) Player {
	return Player{
//		vraklib: vraklib
//		server: server
		ip: ip
		port: port
	}
}

fn (p Player) hash_code() int {
	return 0
}
