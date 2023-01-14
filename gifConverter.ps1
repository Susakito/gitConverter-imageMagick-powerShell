echo $(Get-Date -format "dd-MMM-yyyy HH:mm:ss")
Set-Location "C:\Program Files\ImageMagick-7.1.0-Q16-HDRI"

$source = "Directory" #palitan to kung saan yung source //bawal meron "[]" sa pangalan. di madtect
$magick = "C:\Program Files\ImageMagick-7.1.0-Q16-HDRI\magick.exe"

Get-ChildItem $source -Recurse -Include *.webp | #palitan yung "*.webp accordingly e.g. *.webm"
Foreach-Object { echo "in loop"
    # Determine the number of frames in the webp
    $frames = (& $magick identify -format "%N" $_.FullName) -as [int]

     if($frames -eq 1) {
        # Convert to a PNG
        & $magick $_.FullName -trim "$($_.DirectoryName)/$($_.BaseName).png"
    } elseif($frames -gt 1) {

        #Convert to an animated gif
        & $magick $_.FullName "$($_.DirectoryName)/$($_.BaseName).gif"
    }
    }
echo $(Get-Date -format "dd-MMM-yyyy HH:mm:ss")
