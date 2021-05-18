function ranger --wraps='ranger --choosedir=$HOME/.rangerdir; set LASTDIR (cat $HOME/.rangerdir); cd '
command ranger --choosedir=$HOME/.rangerdir
set LASTDIR (cat $HOME/.rangerdir)
cd $LASTDIR
end
