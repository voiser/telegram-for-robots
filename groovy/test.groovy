import java.net.Socket
import groovy.json.JsonSlurper

class Robot {

  def rcvSocket
  def sndSocket

  def Robot() {
    def host = "localhost"
    def rcvPort = 4001
    def sndPort = 4002
    rcvSocket = new Socket(host, rcvPort)
    sndSocket = new Socket(host, sndPort)
    receive()
  }
  
  def receive() {
    def jsonSlurper = new JsonSlurper()
    rcvSocket.withStreams {input, output -> 
      input.newReader().eachLine() { line ->
        def j = jsonSlurper.parseText(line)
        onReceive(j)
      }
    }
  }
  
  def receiver(msg) {
    if (msg.to.type == "user") return "user#${msg.from.id}"
    throw new RuntimeException("Only peer-to-peer char supported at the moment")
  }
  
  def onReceive(msg) {
    def rcpt = receiver(msg)
    def text = msg.text
    
    if (!text) {
      println "Ignoring message without text"
      return
    }
    
    println "Received from ${msg.from.print_name} ${rcpt}"
    println "  ${text}"
    
    def command = false
    
    switch(text) {
      case "ping":
        command = "msg ${rcpt} pong!"
        break;
      case "pic":
        command = "send_photo ${rcpt} groovy/logo.png"
        break;
    }
    
    if (!command) {
      println "Sorry, I don't understand..."
      return
    }

    println "  Sending back: ${command}"
    sndSocket << command + "\n"
  }
}

new Robot()