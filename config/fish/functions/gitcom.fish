function gitcom --wraps='git commit -m' --description 'alias gitcom=git commit -m'
  git commit -m $argv; 
end
