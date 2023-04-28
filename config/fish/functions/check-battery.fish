function check-battery --wraps='upower -i (upower -e | grep BAT)' --description 'alias check-battery upower -i (upower -e | grep BAT)'
  upower -i (upower -e | grep BAT) $argv
        
end
