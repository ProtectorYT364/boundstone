module bstone

import log
import time
import term

pub struct Log{
/* mut:
	log log.Log */
//pub mut:
pub mut:
	l chan LogMsg
	stop bool = false
	log log.Log
}

pub struct LogMsg{
pub mut:
	m string
	l log.Level = .debug
}

pub fn (shared logger Log) run_logger(){
		println('test1')
	//mut l := log.Log{}
	mut l := logger.log

	logger.log('Logger started $l',.debug)
		println('test2')
	//logger.l <- LogMsg{'Logger started $logger.log',.debug}
	//logger.log('Logger started $logger.log',.debug)
	//}

	//for !logger.l.closed {//TODO check if infinite
		mut m := LogMsg{}
		lock logger{
	println(logger.l.len)
		for !logger.stop {
			if logger.l.try_pop(m) == .success{
			println(logger.l.len)
		println('test3')
		/* m = <-logger.l or {
			panic('Could not read stream $err')
			//break//returns when closed
			return
		} */
		
		println('Yes, got $m')
		f := tag_to_cli(m.l)
		t := time.now()
		println('[$f $t.format_ss()] $m.m')//print to cli
		
		match m.l {//log to file
			//lock{
				.fatal { logger.log.fatal(m.m) }/* } */
			/* lock{ */ .error {logger.log.error(m.m) }/* } */
			/* lock{ */.warn { logger.log.warn(m.m) }/* } */
			/* lock{ */.info { logger.log.info(m.m) }/* } */
			/* lock{ */.debug { logger.log.debug(m.m) }/* } */
			//}
		}
		//}
	}//}
	println(logger.l.len)
		}}

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

pub fn(shared logger Log) log(m string, l log.Level){
	msg := LogMsg{m,l}
	println('Logging $m $l $msg')
	//logger.l <- LogMsg{m,l} //or { panic(err)}
	
	lock logger{
	println(logger.l.len)
		
	logger.l.try_push(msg)
	println(logger.l.len)
	logger.stop()
	}
	//logger.l.try_push(LogMsg{m,l})
	println('Success')
}

pub fn(mut logger Log) stop(){
	println('Stopping logger...')
	logger.stop = true
}