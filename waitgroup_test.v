module main

import sync
import time

struct ABC {
	s string
}

fn test_shared() {
	mut wg := sync.new_waitgroup()
	wg.add(2)

	go goa(mut wg)
	go gob(mut wg)
	println('before wait')
	wg.wait()
	println('after wait')
}

fn goa(mut wg sync.WaitGroup) {
	println('a')
	wg.done()
}

fn gob(mut wg sync.WaitGroup) {
	println('b')
	time.sleep(5 * time.second)
	wg.done()
}
