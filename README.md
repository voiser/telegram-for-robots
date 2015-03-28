# telegram-for-robots

## installation

### clone this repository

- $ git clone --recursive https://github.com/voiser/telegram-for-robots

### compile submodule tg

- follow the instructions found in: https://github.com/vysheng/tg
- please be aware of this bug: https://github.com/vysheng/tg/issues/440

### install some dependencies

- install luarocks
- $ luaricks install luasocket

## usage

### first launch: log in to telegram

- $ ./login.sh
- Enter your phone number (+xx.....) and the received code.
- The application will close

### launch the server

- $ ./launch.sh

## How does it work?

- connect to port 4001 to receive all incoming messages in JSON format.
- connect to port 4002 to send commands (send text, video, etc)

Refer to https://github.com/vysheng/tg for a list of the available commands (or use the help command)


## How do I create my bot?

You have a very simple python3 example:

- $ cd python3 
- $ python3 test.py

Fell free to translate it to other language, and don't forget to send me the pull request.
