# Defined via `source`
function nvim --wraps=vim --wraps=/usr/local/bin/nvim.appimage --description 'alias nvim /usr/local/bin/nvim.appimage'
  /usr/local/bin/nvim.appimage $argv; 
end
