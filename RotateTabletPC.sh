#!/bin/bash

#シンプルに通常の画面をPCモード、縦画面をタブレットモードとして切り替える

#対象のデバイスのIDは　xinput list で確認
touch_display_multi=11
touch_display_stylus=18
trackpad=13

rotation=$(xrandr -q --verbose | grep eDP-1 | egrep -o "(normal|left)" | head -1)
if [ "$rotation" = "normal" ] ; then
    xrandr --output eDP-1 --rotate left
    xinput set-prop $touch_display_multi 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
    xinput set-prop $touch_display_stylus 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
    xinput set-prop $trackpad 'Device Enabled' 0
else
    xrandr --output eDP-1 --rotate normal
    xinput set-prop $touch_display_multi 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    xinput set-prop $touch_display_stylus 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    xinput set-prop $trackpad 'Device Enabled' 1
fi
