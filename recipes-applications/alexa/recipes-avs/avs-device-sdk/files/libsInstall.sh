#!/bin/bash
fullpath=$1
filename="${fullpath##*/}"
ln -s $fullpath $filename
chrpath -r "/home/root/Alexa_SDK/libs" $fullpath
