module main

struct ABC {
	s string = ''
}

fn test_shared() {
	shared abc := foo() or { panic('scared') }
}

fn foo() ?ABC {
	a := ABC{}
	a.bar() ?
	return a
}

fn (a ABC) bar() ? {
	println(a.s)
	panic('boo!')
}
