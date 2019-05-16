#!/bin/bash

#シンプルに通常の画面をPCモード、縦画面をタブレットモードとして切り替える

#対象のデバイスのIDは　xinput list で確認

input_rotate=(11 18)
input_disable=(13)
output="eDP-1"

rotation=$(xrandr -q --verbose | grep $output | egrep -o "(normal|left)" | head -1)
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
