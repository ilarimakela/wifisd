#!/bin/bash

for file in $(find lib/ -regex ".*sh$" ! -name autoload.sh)
do
	source $file	
done
