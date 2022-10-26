#!/bin/bash

function portscan
{
for ((counter=3000; counter<=5500;counter++))
do
	(echo >/dev/tcp/127.0.0.1/$counter) > /dev/null 2>&1 && echo "$counter open"
done
}

portscan
