import frida
import sys
from rich import print, print_json
from frida import get_local_device


def on_message(msg, data):
    if msg["type"] == "send":
        print(msg["payload"])
    else:
        print_json(data=msg)


device = get_local_device()
pid = device.spawn(["dga.exe", "14", "5", "2015", "0xb6354bc3"], stdio="pipe")
session = device.attach(pid)

script = session.create_script(open("dga.js").read())
script.on("message", on_message)
script.load()
frida.resume(pid)
sys.stdin.read()
frida.kill(pid)
