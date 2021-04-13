fn test_slice_if_not_linear() {
	mut packets := [0,1,2,4,6,7,10]
	println(packets.str())

	mut buf := packets.clone()
	mut pointer := 0
	mut parts := [][]int{}

	for {
		if buf.len <= 2 {
			//fill with leftover buffer
			parts << buf
			break
		}
		pointer++
		//as long as linear
		if buf[pointer] - buf[pointer-1] == 1 {
			continue
		}
		//extract slice
		parts << buf[..pointer]
		buf = buf[pointer..]
		//reset pointer
		pointer = 0
	}

	println(parts.str())
}