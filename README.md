# telegram-for-robots

## installation

### clone this repository

- git clone --recursive https://github.com/voiser/telegram-for-robots

### compile submodule tg

- follow the instructions found in: https://github.com/vysheng/tg
- please be aware of this bug: https://github.com/vysheng/tg/issues/440

### install some dependencies

- install luarocks
- luaricks install luasocket

## usage

### first launch: log in to telegram

- ./login.sh
- Enter your phone number (+xx.....) and the received code.
- The application will close

### launch the server

- ./launch.sh

### use it!

- telnet localhost 4001

You will receive all incoming messages in JSON format. 

- (in telnet) msg user#xxxx Hi there!

You can use any tg commands. Refer to https://github.com/vysheng/tg for a list of the available commands.


