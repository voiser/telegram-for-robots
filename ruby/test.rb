require 'socket'
require 'json'

class Robot
  
  # Initializes the robot. 
  # It will open two sockets: one to receive incoming messages (port 4001)
  # and the other to send commands to the tg client.
  def initialize()
    @host = "localhost"
    @port_rcv = 4001
    @port_snd = 4002
      
    @socket_rcv = TCPSocket.new @host, @port_rcv
    @socket_snd = TCPSocket.new @host, @port_snd
    receive
  end
  
  # Blocks the robot until some incoming message arrives
  def receive
    while line = @socket_rcv.gets
      j = JSON.parse line
      on_receive(j)
    end
  end
  
  # Gets the receiver ID of a given message
  def receiver(msg)
    if msg["to"]["type"] == "user" then
      return "user##{msg["from"]["id"]}"
    end
    raise Exception.new("Only peer-to-peer char supported at the moment")
  end
  
  # Called when an incoming message arrives
  def on_receive(msg)
    rcpt = receiver(msg)
    text = msg["text"]
    
    if not text then
      puts "Ignoring message without text"
      return
    end
    
    puts "Received from #{msg["from"]["print_name"]} #{rcpt}"
    puts "  #{text}"
    
    command = case text
      when "ping" then "msg #{rcpt} pong!"
      when "pic" then "send_photo #{rcpt} ruby/logo.png"
    end
    
    if not command then
      puts "Sorry, I don't understand..."
      return
    end

    puts "  Sending back: #{command}"
    @socket_snd.print "#{command}\n"
  end
end

Robot.new()
