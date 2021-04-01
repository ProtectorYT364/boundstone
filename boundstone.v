//module main

// import sync
import bstone
import vraklib
import term
import os
import net
import sync
import log
import time

fn main() {
	// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
	term.clear()

	mut l := log.Log{}
	l.set_level(.info)//TODO from config
	l.set_output_level(.debug)//TODO from config
	// Make a new file called server.log in the current folder
	l.set_full_logpath('./server.log')
	println('Logging to $l.output_file_name')

	shared logger := &bstone.Log{
		log: &l
	}

	address := '0.0.0.0:19132'
	saddr, port := net.split_address(address) or { 
		panic(err)
	}
	shared config := bstone.ServerConfig{
		addr: net.Addr{
			saddr: saddr
			port: port
		}
	}

	// TODO spawn multiple threads https://github.com/vlang/v/blob/master/doc/docs.md#concurrency
	mut threads := []thread{}

	// TODO dynamic version string
	logger.log(term.bg_black(term.red(term.bold('■ boundstone MCPE v0.0.1 ■'))), .info)
	logger.log('SECOND LOG', .info)

	// TODO Data share between threads
	logger.log(config.addr.str(),.debug)

	mut raklib := vraklib.new_vraklib(config)
	mut server := bstone.new_server(config) // or { panic(err) }

	threads << go raklib.start(shared logger)//maybe pass config here
	threads << go server.start(shared logger)//maybe pass config here
	
	//threads << go read_input(shared logger)

	for {
		command := read_input()
		logger.log('Got command: "$command"',.debug)
		if command == 'stop'{
			lock config{config.shutdown = true}
			break
		}
	}

	
	logger.log(term.bg_black(term.green('Use "stop" for shutdown')), .info)

	raklib.stop()
	server.stop()

	threads.wait()

	logger.log(term.warn_message('Shutting down..'),.warn)
	//lock logger{logger.l.close()}

	println(term.warn_message('Server stopped'))
}

fn read_input() string{
	return os.input('')
}