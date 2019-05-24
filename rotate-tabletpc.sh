#!/bin/bash

input_rotate=(11 18) #Touch display for finger and stylus
input_disable=(13) #Touchpad

output="eDP-1"

rotation=$(xrandr --verbose | grep $output | egrep -o "(normal|left)" | head -1)
if [ "$rotation" = "normal" ] ; then
    xrandr --output $output --rotate left
    for var in ${input_rotate[@]};do
      xinput set-prop $var 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
    done
    for var in ${input_disable[@]};do
      xinput set-prop $var 'Device Enabled' 0
    done
else
    xrandr --output $output --rotate normal
    for var in ${input_rotate[@]};do
      xinput set-prop $var 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    done
    for var in ${input_disable[@]};do
      xinput set-prop $var 'Device Enabled' 1
    done
fi
