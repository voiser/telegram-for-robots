# telegram-for-robots

## installation

- Install https://github.com/vysheng/tg to $WHEREVER
- luarocks install luasocket
- cp *lua $WHEREVER
- cd $WHEREVER 
- ./bin/telegram-cli -k tg-server.pub -s server.lua -P 4002

Connect to port 4001 to receive all incoming messages in JSON format and send tg commands (send messages, media, etc.)

Connect to port 4002 to send tg commands in an interactive fashion. 

