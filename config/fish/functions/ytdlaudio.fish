function ytdlaudio --wraps='youtube-dl --extract-audio --audio-format mp3' --description 'alias ytdlaudio=youtube-dl --extract-audio --audio-format mp3'
  youtube-dl --extract-audio --audio-format mp3 $argv; 
end
