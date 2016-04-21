#!/bin/bash

data=$1

`echo -n -e "$1" | nc -v 192.168.0.108 37777`