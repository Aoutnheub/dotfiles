if [ $# -lt 1 ]; then
    echo 'Error > Missing arguments...'
elif [ $# -gt 3 ]; then
    echo 'Error > Too many arguments...'
else
    if [ ! -d "$1" ]; then
        echo 'Error > "$1" is not a directory...'
    else
        IFS=$'\n'
        files=($(ls -1a "$1" | grep "$2"))
        unset IFS
        if [ -d "$3" ]; then
            for file in "${files[@]}"; do
                cp "$1"/"$file" "$3"
            done
        else
            echo 'Error > "$3" is not a directory...'
        fi
    fi
fi
