function ls --wraps='ls -1ashlAF --color=always' --wraps='lsd -1ahlAF' --wraps=lsd --description 'alias ls lsd'
  lsd $argv; 
end
