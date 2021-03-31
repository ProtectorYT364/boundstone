module main

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
	mut config := bstone.ServerConfig{}
	address := '0.0.0.0:19132'
	saddr, port := net.split_address(address) or { config.log(err, .fatal )
	return }
	config.addr = net.Addr{
		saddr: saddr
		port: port
	}

	// TODO spawn multiple threads https://github.com/vlang/v/blob/master/doc/docs.md#concurrency
	// mut threads := []thread{}

	// available colors are: black,blue,yellow,green,cyan,gray,bright_blue,bright_green,bright_red,bright_black,bright_cyan
	term.clear()
	// TODO dynamic version string
	config.log(term.bg_black(term.red(term.bold('■ boundstone MCPE v0.0.1 ■'))), .info)

	// threads <<
	go run_logger(config.l)

	// TODO Data share between threads
	config.log(config.addr.str(),.debug)
	mut raklib := vraklib.new_vraklib(config.addr)
	// threads <<
	go raklib.start()//maybe pass config here
	//mut server := bstone.new_server(config) // or { panic(err) }
	// threads <<
	//server.start()//maybe pass config here
	
	config.log(term.bg_black(term.green('Use "stop" for shutdown')), .info)
	mut read_line := os.input('> ')//todo read in coroutine
	for {
		if read_line == 'stop' {
			break
		} else {
			read_line = os.input('> ')
		}
	}
	config.log(term.warn_message('Shutting down..'),.warn)
	// raklib.stop()
	//server.stop()
	// threads.wait()
	println(term.warn_message('Server stopped'))
}

pub fn run_logger(stream chan bstone.LogMsg){
	mut log := log.Log{}
	log.set_level(.debug)//TODO from config
	// Make a new file called server.log in the current folder
	log.set_full_logpath('./server.log')
	stream <- bstone.LogMsg{'Logger started',.debug}

	for {
		m := <-stream or {
			break//returns when closed
		}
		f := tag_to_cli(m.l)
		t := time.now()
		println('[$f $t.format_ss()] $m.m')//print to cli
		match m.l {//log to file
			.fatal { log.fatal(m.m) }
			.error { log.error(m.m) }
			.warn { log.warn(m.m) }
			.info { log.info(m.m) }
			.debug { log.debug(m.m) }
		}
	}

	println('Logger stopped')//todo maybe move into or
}

// tag returns the tag for log level `l` as a string. From log because not public TODO find a way to remove
fn tag_to_cli(l log.Level) string {
	return match l {
		.fatal { term.red('FATAL') }
		.error { term.red('ERROR') }
		.warn { term.yellow('WARN ') }
		.info { term.white('INFO ') }
		.debug { term.blue('DEBUG') }
	}
}