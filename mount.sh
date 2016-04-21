#!/bin/bash

#mount drive
cryptsetup luksOpen /home/anon/ck volume
mount /dev/mapper/volume /home/anon/mount