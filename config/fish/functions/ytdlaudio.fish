function ytdlaudio --wraps='yt-dlp --extract-audio --audio-format mp3' --description 'alias ytdlaudio=yt-dlp --extract-audio --audio-format mp3'
  yt-dlp --extract-audio --audio-format mp3 $argv;
end
