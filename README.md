# armory_electron_runtime

Electron based player and html5 debug runtime for armory.


## Build + Install

Make sure `$ARMSDK` variable is set and run:
```sh
npm install
npm run build
npm run pack:linux # linux|darwin|windows
npm run install:linux # linux|darwin|windows
```
Player is now installed at `$ARMSDK/Player/electron`


## Usage

Set the command to use for launching the html5 player:
```sh
export ARMORY_PLAY_HTML5='$ARMSDK/Player/electron/armory_html5_player $ARMSDK/Player/electron/ --window ${width}x${height} $dir/debug/html5/index.html'
```

Start your project in blender and hit `Play` using the `Browser` player.

