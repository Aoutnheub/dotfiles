function umnt --wraps='sudo umount ~/mnt' --description 'alias umnt sudo umount ~/mnt'
  sudo umount ~/mnt $argv;
end
