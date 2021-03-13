import encoding.binary

mut buf := []byte{len:16}
//println(buf)
//buf << 1
//println(buf)
//buf << 2
//println(buf)
//buf << [3,4,5]
//println(buf)
//println(buf[2..3])
//println(buf[..1])
//buf = buf[1..]
//println(buf)
//println(buf[0])
//buf = buf[1..]
//println(buf)
println(buf)
binary.big_endian_put_u16(mut buf, u16(1))
println(buf)
binary.big_endian_put_u16(mut buf, u16(2))
println(buf)
println(binary.big_endian_u16(buf))
println(buf)
println(binary.big_endian_u16(buf))
println(buf)