#!/bin/bash

CAMERA_IP="192.168.0.18"

DOWNLOAD_FOLDER="/tmp/WifiSD/"

DOWNLOAD_URL="http://$CAMERA_IP/cgi-bin/wifi_download?fn="
ROOT_FOLDER="/www/sd/DCIM"
TSLIST="http://$CAMERA_IP/cgi-bin/tslist?keeprefresh=$(date '+%Y%m%d%H%M%S')"
