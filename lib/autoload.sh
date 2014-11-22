#!/bin/bash

find lib/ -regex ".*sh$" ! -name autoload.sh -exec source "$file" \;
