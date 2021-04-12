import bstone
import vraklib
import os
import logger

fn init() {
	println('INIT')
}

fn main() {
	// settings
	cfg := bstone.load_settings() or { panic('Could not load settings: $err') } // If we would assign to a `shared` directly, we would get a compiler error. See shared_crash_test.v
	logger.log(cfg.str(), .debug)
	shared settings := bstone.Settings{
		...cfg
	}
	rlock settings {
		logger.log(settings.str(), .debug)
	}
	rlock settings {
		logger.level(settings.log_level, settings.log_output_level)
	}

	// TODO spawn multiple threads https://github.com/vlang/v/blob/master/doc/docs.md#concurrency
	mut threads := []thread{}

	// TODO dynamic version string
	logger.log('■ boundstone MCPE v0.0.1 ■', .info)

	// TODO Data share between threads for sessions
	mut raklib := vraklib.new_vraklib(shared settings)
	mut server := bstone.new_server(shared settings)

	threads << go raklib.start()
	threads << go server.start()
	logger.log('Use "CTRL-C" for shutdown', .info)
	//threads << go read_input(shared settings)

	// for {
	// 	command := read_input()
	// 	logger.log('Got command: "$command"', .debug)
	// 	if command == 'stop' {
	// 		lock config {
	// 			config.shutdown = true
	// 		}
	// 		break
	// 	}
	// }

	// logger.log('Shutting down..', .warn)
	// raklib.stop()
	// server.stop()

	threads.wait() // TODO check why this is so far down
	logger.log('Server stopped', .warn)
}



fn read_input() string {
	return os.input('')
}

