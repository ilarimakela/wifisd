#!/bin/bash

function isCameraOnline {
	ping -qa -t 2 -c 1 $CAMERA_IP > /dev/null
}
