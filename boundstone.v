import bstone
import readline
import vraklib
import sync

mut running := true
//TODO: serversettings
address := vraklib.InternetAddress { ip: '0.0.0.0', port: u16(19132), version: byte(4) }
// Threads
mut server := bstone.Server { name: 'Testserver', address: address}
mut raklib := vraklib.VRakLib {}
// Data share
//channel or sth here

    ch1 := chan vraklib.OpenSessionData{}
    ch2 := chan vraklib.HandleEncapsulatedData{}
    ch3 := chan vraklib.PutPacketData{}

    raklib = vraklib.VRakLib { address: address }
    go raklib.start(ch1, ch2, ch3)

    server.start()

    mut rl := readline.Readline{}
    rl.enable_raw_mode()
    for {
        line := rl.read_line('')
        if line == 'stop\n' {
            raklib.stop()
            server.stop()
            break
        }
    }
    rl.disable_raw_mode()