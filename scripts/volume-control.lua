#!/usr/bin/env lua

local sinks = io.popen('pactl list short sinks | cut -f1', 'r')

local commands = {
    [1] = function (sink) os.execute('pactl set-sink-volume '..sink..' +2%') end,
    [2] = function (sink) os.execute('pactl set-sink-volume '..sink..' -2%') end,
    [3] = function (sink) os.execute('pactl set-sink-mute '..sink..' toggle') end,
}

if #arg == 1 then
    for line in sinks:lines() do
        local cmd = commands[tonumber(arg[1])]
        if cmd then
            cmd(line)
        else
            print('No')
        end
    end
else
    print('One arg pls')
end

sinks:close()
