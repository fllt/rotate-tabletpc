# rotate-like-tablet

タブレットのように縦持ちできるよう、画面を回転させる｡

## 目的

シンプルに通常の向きをPCモード、横向きをタブレットモードとして、画面の向きを切り替える｡

## 動作確認

ASUS Vivobook flip 12 TP203NA
xubuntu 19.04

## 使い方

### ダウンロード


```
git clone https://github.com/fllt/rotate-tabletpc.git
```

### 設定の編集

自分のTP203NAに合わせて設定されているため､他のハードウェアで使う場合修正する必要がある｡

#### 入力デバイスのidを確認する

画面の回転に伴ってタッチの判定も回転させる必要があるため､そのために入力デバイスのidを確認する必要がある

```
$ xinput list
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
今回の場合 *11* と *18* がタッチディスプレイでこれを回転させる｡ペン用とそうでないマルチタッチがそれぞれ別のデバイスとして認識されているようなので､どちらも回転させる｡
また､ *13* はタッチパッドでこれは無効化する｡TP203NAの場合キーボードを裏返すとキーボードが無効化されるが､タッチパッドは無効化されなかったため｡

#### 出力先の確認する
出力先の名前を確認する｡

```
$ xrandr --listmonitorsMonitors: 1
 0: +eDP-1 1366/256x768/144+0+0  eDP-1
```
この場合 *eDP-1* を使う
とはいえ入力デバイスと違い､内蔵ディスプレイが複数あることは考えづらいので､基本的 *eDP-1* でいい気がする


上で確認した値をもとに以下の箇所を設定し､上書きする
```Bash:rotate-tabletpc.sh
input_rotate=(11 18) #Touch display for finger and stylus
input_disable=(13) #Touchpad

output="eDP-1"
```

### インストール

”~/bin/”など、PATHの通ったディレクトリにコピーする

```
cp rotate-tabletpc.sh ~/bin/
```

### 実行する

```
rotate-tabletpc.sh
```
実行するたびに通常と縦向きが入れ替わる

ショートカットキーやランチャーにコマンドを設定すると便利


###アンインストール

```
rm ~/bin/rotate-tabletpc
```

## 今後の課題

### 4方向への対応
今は通常と右向きのみだが、いずれは他の方向にも対応したい
とはいえ4方向だと今のような一つのコマンドでON/OFFを切り替えるわけにもいかないので
対応したところで操作の煩雑化が割に合わない気もする

### Kindleの対応
どういうわけか試したアプリケーションの中でkindleだけ、縦画面にしても画面が縦に広がらず、中途半端なサイズだった。
正直タブレットモードにしたかったのははkindleのためだったので、これを解決しないと意味がないのだが...
おそらくこれだけwine上で動かしているというのが原因だとは思うのだが、
