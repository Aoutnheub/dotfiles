# Defined in - @ line 1
function kclear --wraps=printf\ \"\\033\[3J\\033\[H\" --description alias\ kclear\ printf\ \"\\033\[3J\\033\[H\"
  printf "\033[3J\033[H" $argv;
end
