import log

struct Logger {
mut:
	l log.Log// data to shared
}

fn (shared l Logger) start_logger() {
	if int(l.level) < int(log.Level.debug) {
		return
	}
	l.send_output(l, .debug)
}