import select
import socket
import json
import threading

class Robot:
    
    def __init__(self):
        """ Initializes the robot. 
        It will open two sockets: one to receive incoming messages (port 4001)
        and the other to send commands to the tg client.
        """
        self._host = "localhost"
        self._port_rcv = 4001
        self._port_snd = 4002
        self._socket_rcv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self._socket_snd = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self._socket_rcv.connect((self._host, self._port_rcv))
        self._socket_snd.connect((self._host, self._port_snd))
        self.receive()
        
    def receive(self):
        """ Blocks the robot until some incoming message arrives """
        f = self._socket_rcv.makefile()
        while True:
            line = f.readline().strip()
            j = json.loads(line)
            self.on_receive(j)

    def receiver(self, msg):
        """ Gets the receiver ID of a given message """
        if msg["to"]["type"] == "user":
            return "user#%d" % (msg["from"]["id"])
        raise Exception("Only peer-to-peer char supported at the moment")

    def on_receive(self, msg):
        """ Called when an incoming message arrives """
        rcpt = self.receiver(msg)
        if not "text" in msg:
            print("Ignoring message without text")
            return
            
        text = msg["text"]
        print("Received from", msg["from"]["print_name"], rcpt)
        print("  ", text)
        command = ""

        # Poor man's message dispatching.
        if text == "ping":
            command = "msg %s pong!\n" % (rcpt)
            
        elif text == "pic":
            command = "send_photo %s python3/logo.png\n" % (rcpt)
            
        else:
            print("Sorry I don't understand...")
            return
            
        print("  Sending back:", command)
        self._socket_snd.send(command.encode("UTF-8"))
        
if __name__ == "__main__":
    robot = Robot()
    
