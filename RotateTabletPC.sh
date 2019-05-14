#とりあえずはシンプル切り替えられるように通常の画面をPCモード、縦画面をタブレットモードとして切り替える感じにする
#対象のデバイスは　xinput list で確認
#自分の場合は1１がマルチタッチ、18がペンらしかったのでそれを画面と一緒に回転

rotation=$(xrandr -q --verbose | grep eDP-1 | egrep -o "(normal|left)" | head -1)
if [ "$rotation" = "normal" ] ; then
    xrandr --output eDP-1 --rotate right
    xinput set-prop 11 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
    xinput set-prop 18 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1

else
    xrandr --output eDP-1 --rotate normal
    xinput set-prop 11 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    xinput set-prop 18 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
fi
