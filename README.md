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

### login into telegram (if you haven't)

- ./login.sh
- Enter your phone number (++xx.....) and the received code.
- The application will close

### launch the server

- ./launch.sh

### use it!

Connect to port 4001 to receive all incoming messages in JSON format and send tg commands (send messages, media, etc.)

Connect to port 4002 to send tg commands in an interactive fashion. 

