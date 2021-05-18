# Defined via `source`
function hornifetch --wraps='neofetch --backend kitty --source ~/Pictures/calli-cake.jpg --size 300px' --description 'alias hornifetch=neofetch --backend kitty --source ~/Pictures/calli-cake.jpg --size 300px'
  neofetch --backend kitty --source ~/Pictures/calli-cake.jpg --size 300px $argv;
end
