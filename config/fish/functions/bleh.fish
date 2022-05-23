function bleh --wraps='feh -Z --scale-down' --description 'alias bleh feh -Z --scale-down'
    feh -Z --scale-down $argv & disown %1
end
