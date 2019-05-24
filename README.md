# rotate-tabletpc

Rotate display with touch panel like tablet PC.

## Requirements

ASUS Vivobook flip 12 TP203NA
xubuntu 19.04

## Usage

### Download

```
git clone https://github.com/fllt/rotate-tabletpc.git
```

### Fix variant

This script is written for my TP203NA.
So, if you use on other devices,you need to fix some variants.

#### Check id of input devices.


```
$ xinput list
```

Results on TP203NA

```
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ ELAN24C9:00 04F3:24C9                   	id=11	[slave  pointer  (2)]
⎜   ↳ ELAN1201:00 04F3:3054 Touchpad          	id=13	[slave  pointer  (2)]
⎜   ↳ ELAN24C9:00 04F3:24C9 Pen (0)           	id=18	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Asus Wireless Radio Control             	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Power Button                            	id=8	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=9	[slave  keyboard (3)]
    ↳ USB2.0 VGA UVC WebCam: USB2.0 V         	id=10	[slave  keyboard (3)]
    ↳ ELAN24C9:00 04F3:24C9                   	id=12	[slave  keyboard (3)]
    ↳ Asus WMI hotkeys                        	id=14	[slave  keyboard (3)]
    ↳ gpio-keys                               	id=15	[slave  keyboard (3)]
    ↳ gpio-keys                               	id=16	[slave  keyboard (3)]

    ↳ AT Translated Set 2 keyboard            	id=17	[slave  keyboard (3)]
```
In this case, id=11 and id=18 are touchdisplay.(One is multi touch and another is stylus.) 
Rotate them.

id=13 is Touchpad under keybourd. This is unenable.(Because when TP203 flip keybourd,unenable keybourd but touchpad is not unenable).

#### Check output display

```
$ xrandr --listmonitors
```

Result on TP203NA

```
Monitors: 1
 0: +eDP-1 1366/256x768/144+0+0  eDP-1
```

In this case, use *eDP-1* .
Although, unlike input devices, it is hard to imagine that embedded more than one display.
So, I think that basically you ca use *eDP-1* .

#### Fix *rotate-tabletpc.sh* 

Fix berow section besed on checked values.

```Bash:rotate-tabletpc.sh
input_rotate=(11 18) #Touch display for finger and stylus
input_disable=(13) #Touchpad

output="eDP-1"
```

### Install


```
cd rotate-tabletpc
cp rotate-tabletpc.sh ~/bin/
```

### Execute

```
rotate-tabletpc.sh
```



With each execution, switching display rotation between normal and left.


I recomend to set the comannd to keybourd shortcuts or Launcher. 


### Uninstall

```
rm ~/bin/rotate-tabletpc
```


