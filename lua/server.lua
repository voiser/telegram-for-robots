--
-- Telegram for robots
--

started = 0
our_id = 0

local JSON = (loadfile "lua/JSON.lua")()
local socket = require("socket")

local MY_SOCKET = 4001
local TG_SOCKET = 4002

function vardump(value) 
  print(JSON:encode(value))
end

function ok_cb(extra, success, result)
end

function on_msg_receive (msg)
  if started == 0 then
    return
  end
  if msg.out then
    return
  end
  local j = JSON:encode(msg)
  for i, client in ipairs(clients) do
    client:send(j .. "\n")
  end
end

function on_our_id (id)
  our_id = id
end

function cron()
  postpone (cron, false, 0.1)
  --coroutine.resume (clientsCoroutine)
  coroutine.resume (serverCoroutine)
end

function on_binlog_replay_end ()
  started = 1
  postpone (cron, false, 1)
end

function on_user_update (user, what)
end

function on_chat_update (chat, what)
end

function on_secret_chat_update (schat, what)
end

function on_get_difference_end ()
end

function runTCPServer()
  local server, err = socket.tcp()
  server:setoption("reuseaddr", true)
  server:bind("localhost", 4001)
  server:listen(16)
  --commands = socket.tcp()
  --commands:connect("localhost", 4002)
  while (true) do
    server:settimeout(0.01)
    local client, err = server:accept()
    if client ~= nil then
      table.insert(clients, client)
    end
    coroutine.yield()
  end
end

function readClients()
  while (true) do
    local available = socket.select(clients, nil, 1)
    for i, client in ipairs(available) do
      local line, err = client:receive()
      if line == nil then
        table.remove(i)
      else
        print("Received from socket", line)
        dispatch(line)
      end
    end
    coroutine.yield()
  end
end

function dispatch(cmd) 
  commands:send(cmd .. "\n")
end

stop_server = 0
clients = {}
commands = 0
serverCoroutine = coroutine.create(runTCPServer)
-- clientsCoroutine = coroutine.create(readClients)
