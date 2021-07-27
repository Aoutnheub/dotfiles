function mnt --wraps='sudo mount /dev/sdb1 ~/mount' --description 'alias mnt sudo mount /dev/sdb1 ~/mount'
  sudo mount /dev/sdb1 ~/mount $argv; 
end
