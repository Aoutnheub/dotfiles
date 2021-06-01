# Defined via `source`
function clear --wraps=printf\ \"\\033\[2J\\033\[3J\\033\[H\" --description alias\ clear\ printf\ \"\\033\[2J\\033\[3J\\033\[H\"
  printf "\033[2J\033[3J\033[H" $argv; 
end
