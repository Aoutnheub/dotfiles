function mnt --wraps='sudo mount /dev/sda1 ~/mnt' --description 'alias mnt sudo mount /dev/sda1 ~/mnt'
  sudo mount /dev/sda1 ~/mnt $argv;
end
