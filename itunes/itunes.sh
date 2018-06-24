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
    echo -e "Currently playing: \n\n${bold}$track\n$artist (💿  $album)${normal}";
else
    echo "iTunes is currently $state.";
fi

art=$(cat <<- EOS
tell application "iTunes" to tell artwork 1 of current track
    set srcBytes to raw data
    if format is «class PNG » then
        set ext to ".png"
    else
    set ext to ".jpg"
    end if
end tell

set fileName to (((path to temporary items) as text) & "itunes_cover" & ext)
set outFile to open for access file fileName with write permission
set eof outFile to 0
write srcBytes to outFile
close access outFile
EOS
)

osascript -e "$art"

if [ "$TERM" == "xterm-kitty" ]
    then
        kitty icat --align=left $TMPDIR/TemporaryItems/itunes_cover.jpg
    else
        imgcat $TMPDIR/TemporaryItems/itunes_cover.{jpg,png} -w $size
fi
rm -f $TMPDIR/TemporaryItems/itunes_cover.{jpg,png}
