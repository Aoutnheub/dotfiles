# Defined in - @ line 1
function sue --wraps='sudo -e' --description 'alias sue sudo -e'
  sudo -e $argv;
end
