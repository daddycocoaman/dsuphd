var dga = Process.getModuleByName("dga.exe");
var gen_addr = ptr(parseInt(dga.base) + 0x1cf00);

Interceptor.attach(gen_addr, {
  // When the function is about to execute
  onEnter: function (args) {
    var entered_args = [
      args[0].readUInt(), // day
      args[1].readUInt(), // month
      args[2].readUInt(), // year
      "0x" + args[3].readUInt().toString(16), // seed
    ];
    send("Function is about to execute with [" + entered_args + "]\n");
  },

  // When the function is about to return
  onLeave: function (result) {
    send("Result pointer: " + result + "\n");
    send("Domains Generated:");
    for (let i = 4; i <= 44; i++) {
      //result in a pointer to a list of pointers (strings) so we need to deference twice
      //Also need to account for 0x10 offsets
      var str_ptr = ptr(parseInt(result.readPointer()) + i * 8 + 0x10);
      var next_str = ptr(parseInt(str_ptr.readPointer()) + 0x10);
      try {
        send(next_str.readCString());
      } catch {
        // Pointer to a string
        continue;
      }
    }
  },
});
