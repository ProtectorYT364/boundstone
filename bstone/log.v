module bstone

import log
import time
import term

pub struct Log{
pub mut:
	log log.Log
}

pub struct LogMsg{
pub mut:
	m string
	l log.Level = .debug
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

pub fn(shared logger Log) log(m string, l log.Level){
		println('Logging $l $m')
		f := tag_to_cli(l)
		t := time.now()
		println('[$f $t.format_ss()] $m')//print to cli
		
	lock logger{
		match l {//log to file TODO figure out how to get rid of the colors
				.fatal { logger.log.fatal(m) }
			 .error {logger.log.error(m) }
			.warn { logger.log.warn(m) }
			.info { logger.log.info(m) }
			.debug { logger.log.debug(m) }
		}
	}
}

pub fn(mut logger Log) stop(){
	println('Stopping logger...')
	//logger.stop = true
}