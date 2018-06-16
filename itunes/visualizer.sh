#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
clear

if [ -z "$1" ]
    then
        size=40
    else
	size=$1
fi

state=`osascript -e 'tell application "iTunes" to player state as string'`;
if [ $state = "playing" ]; then
    artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`;
    track=`osascript -e 'tell application "iTunes" to name of current track as string'`;
    album=`osascript -e 'tell application "iTunes" to album of current track as string'`;
    echo "Currently playing: \n\n${bold}$track\n$artist (💿  $album)${normal}";
else
    echo "iTunes is currently $state.";
fi

: '
# OPTION 1: run applescript here and save img in desktop

art=$(cat <<- EOS
tell application "iTunes" to tell artwork 1 of current track
    set srcBytes to raw data
    if format is «class PNG » then
        set ext to ".png"
    else
    set ext to ".jpg"
    end if
end tell

log (do shell script "pwd" as text)

set fileName to (((path to desktop) as text) & "_cover" & ext)
-- set fileName to ((do shell script "pwd" as text) & "itunes_cover" & ext)
log fileName
set outFile to open for access file fileName with write permission
set eof outFile to 0
write srcBytes to outFile
close access outFile
EOS
)

# OPTION 2: running art.scpt script and saving img in $HOME/bin
# OPTION 3: passing buffer to imgcat ?
'

osascript art.scpt
# osascript -e "$art"
imgcat *_cover.* -w $size
rm -f art.scpt_cover.{jpg,png}
