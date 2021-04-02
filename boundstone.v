import bstone
import vraklib
import term
import os
import net
import log
import time
import json

fn main() {
	// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
	term.clear()

	// settings
	mut settings := load_settings() or { panic('Could not load settings: $err') }

	// log
	mut l := log.Log{}
	l.set_level(settings.log_level)
	l.set_output_level(settings.log_output_level)
	l.set_full_logpath('./server.log')
	l.log_to_console_too()
	shared logger := &bstone.Log{
		log: &l
	}

	port := net.validate_port(settings.port_v4) or { panic(err) }
	addr := net.Addr{
		saddr: settings.ip_v4
		port: port
	}
	shared config := bstone.ServerConfig{
		addr: addr
	}

	// TODO spawn multiple threads https://github.com/vlang/v/blob/master/doc/docs.md#concurrency
	mut threads := []thread{}

	// TODO dynamic version string
	logger.log(term.red(term.bold('■ boundstone MCPE v0.0.1 ■')), .info)

	// TODO Data share between threads
	mut raklib := vraklib.new_vraklib(shared config, shared logger)
	mut server := bstone.new_server(shared config, shared logger)

	threads << go raklib.start() // maybe pass config here
	threads << go server.start() // maybe pass config here
	logger.log(term.green('Use "stop" for shutdown'), .info)

	for {
		command := read_input()
		logger.log('Got command: "$command"', .debug)
		if command == 'stop' {
			lock config {
				config.shutdown = true
			}
			break
		}
	}

	logger.log('Shutting down..', .warn)
	raklib.stop()
	server.stop()

	threads.wait() // TODO check why this is so far down
	logger.log('Server stopped', .warn)
}

fn read_input() string {
	return os.input('')
}

struct Settings {
	ip_v4            string    = '0.0.0.0'
	port_v4          u16       = 19132
	max_players      int       = 100
	name             string    = 'boundstone MCPE'
	motd             string    = 'Written in V'
	gamemode         string    = 'Creative'
	show_version     bool      = true
	log_level        log.Level = .info
	log_output_level log.Level = .debug
}

fn load_settings() ?Settings {
	path := './server.json'
	if !os.exists(path) {
		settings := Settings{}
		settings.save_settings() ?
		return settings
	}
	s := os.read_file(path) ?
	settings := json.decode(Settings, s) ?
	return settings
}

fn (s Settings) save_settings() ? {
	path := './server.json'
	settings := json.encode_pretty(s)
	os.write_file(path, settings) ?
}
