#!/bin/bash

function downloadNewImagesFromCamera {
    scanCamera
}

function scanCamera {
    for FOLDER in $(readFolderFromCamera $"ROOT_FOLDER")
    do
        [[ "$FOLDER" =~ =([a-zA-Z0-9_]*)\& ]] \
            && readSubFolder "${BASH_REMATCH[1]}"
    done
}

function readFolderFromCamera {
    local FOLDER=$1

    curl -s "$TSLIST?PATH"="$FOLDER" \
        | tail -n 1 \
        | sed "s/&FileName/ FileName/g" \
        | sed "s/&FileCount=[0-9]*//"
}

function readSubFolder {
    local SUBFOLDER="$ROOT_FOLDER/$1"
    
    for FOLDER in $(readFolderFromCamera "$SUBFOLDER")
    do
        [[ $FOLDER =~ =([a-zA-Z0-9_\.]*)\& ]] \
            && downloadPhoto "$SUBFOLDER"/"${BASH_REMATCH[1]}"
    done
}

function downloadPhoto {
    local PHOTO_URL=$1
    local PHOTO_FILENAME=$(basename "$PHOTO_URL")
    
    [ "$PHOTO_FILENAME" == "WSD00003.JPG" ] && return 0

    [ -d "$DOWNLOAD_FOLDER" ] || mkdir -p "$DOWNLOAD_FOLDER" || \
        ( echo "mkdir failed for $DOWNLOAD_FOLDER" && exit 1 )

    local LOCAL_FILENAME="$DOWNLOAD_FOLDER"/"$PHOTO_FILENAME"

    if [ ! -f "$LOCAL_FILENAME" ]
    then
        curl -s --location "$DOWNLOAD_URL""$PHOTO_URL" \
                --output /tmp/"$PHOTO_FILENAME"

        mv /tmp/"$PHOTO_FILENAME" "$DOWNLOAD_FOLDER"

        removePhotoFromCamera "$PHOTO_URL"
    fi
}

function removePhotoFromCamera {
    local PHOTO=$1

    echo "Deleting photo from camera $PHOTO..."
}
