module logger

import log as loglog

// pub const log = setup()
const log = setup()

fn setup() loglog.Log {
	mut l := loglog.Log{}
	l.set_level(.debug)
	l.set_output_level(.debug)
	l.set_full_logpath('./server.log')
	l.log_to_console_too()
	return l
}

pub fn level(ll loglog.Level, lo loglog.Level) {
	mut l := get()
	l.set_level(ll)
	l.set_output_level(lo)
}

pub fn get() &loglog.Log {
	return unsafe { &logger.log }
}

pub fn log(m string, l loglog.Level) {
	match l {
		// log to file TODO figure out how to get rid of the colors
		.fatal { get().fatal(m) }
		.error { get().error(m) }
		.warn { get().warn(m) }
		.info { get().info(m) }
		.debug { get().debug(m) }
	}
}
