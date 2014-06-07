#!/bin/bash

cd $(dirname $0)

source settings.sh
source lib/autoload.sh

isCameraOnline \
    && downloadNewImagesFromCamera
