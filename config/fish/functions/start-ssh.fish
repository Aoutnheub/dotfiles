# Defined via `source`
function start-ssh --wraps='eval (ssh-agent -c)' --description 'alias start-ssh eval (ssh-agent -c)'
  eval (ssh-agent -c) $argv; 
end
