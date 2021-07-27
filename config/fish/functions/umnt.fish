function umnt --wraps='sudo umount ~/mount' --description 'alias umnt sudo umount ~/mount'
  sudo umount ~/mount $argv; 
end
