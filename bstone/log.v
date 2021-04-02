module bstone

import log

pub struct Log {
pub mut:
	log log.Log
}

pub fn (shared logger Log) log(m string, l log.Level) {
	lock logger {
		match l {
			// log to file TODO figure out how to get rid of the colors
			.fatal { logger.log.fatal(m) }
			.error { logger.log.error(m) }
			.warn { logger.log.warn(m) }
			.info { logger.log.info(m) }
			.debug { logger.log.debug(m) }
		}
	}
}
