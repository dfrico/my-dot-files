-- get the raw bytes of the artwork into a var
tell application "iTunes" to tell artwork 1 of current track
    set srcBytes to raw data
    -- figure out the proper file extension
    if format is «class PNG » then
        set ext to ".png"
    else
        set ext to ".jpg"
    end if
end tell

-- get the filename to ~/Desktop/cover.ext
set fileName to (((path to me) as text) & "_cover" & ext)
-- write to file
set outFile to open for access file fileName with write permission
-- truncate the file
set eof outFile to 0
-- write the image bytes to the file
write srcBytes to outFile
close access outFile
