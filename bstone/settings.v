module bstone

import os
import log
import json
import net

pub struct Settings {
mut:
	// dont save to json
	run bool [skip]
pub:
	ip_v4            string    = '0.0.0.0'
	port_v4          u16       = 19132
	max_players      int       = 100
	name             string    = 'boundstone MCPE'
	show_version     bool      = true
	log_level        log.Level = .info
	log_output_level log.Level = .debug
pub mut:
	gamemode string = 'Creative'
	motd     string = 'Written in V'
}

pub fn load_settings() ?Settings {
	path := './server.json'
	if !os.exists(path) {
		println('New config')
		settings := Settings{
			run: true
		}
		settings.save_settings() ?
		return settings
	}
	// else{
	println('Old config')
	s := os.read_file(path) ?
	settings := json.decode(Settings, s) ?
	return settings

	//}
}

fn (s Settings) save_settings() ? {
	path := './server.json'
	settings := json.encode_pretty(s)
	os.write_file(path, settings) ?
}

pub fn (s Settings) addr() net.Addr {
	port := net.validate_port(s.port_v4) or { panic(err) }
	return net.Addr{
		saddr: s.ip_v4
		port: port
	}
}

pub fn (shared s Settings) running() bool {
	rlock s {
		return s.run
	}
	return false
}

pub fn (shared s Settings) stop() {
	lock s {
		println(s.str())

		// s.run = false
		// s.run = false
		println(s.str())
	}
}
