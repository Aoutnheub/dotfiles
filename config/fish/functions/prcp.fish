function prcp --wraps='rsync -P' --description 'alias prcp rsync -P'
  rsync -P $argv; 
end
