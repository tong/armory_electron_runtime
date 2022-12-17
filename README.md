# armory_electron_runtime

Electron based player and html5 debug runtime for armory.


## Build

```sh
haxelib install build.hxml # Install haxelib dependencies
npm install # Install node packages
npm run build # Build main process js
npm run pack:linux # linux|darwin|windows
```


## Usage

Set the custom launch command for the html5 player (change `os` and `arch` to your machine):   
Use an absolute path to the executeable if it's not in your `PATH`.  
```sh
export ARMORY_PLAY_HTML5='/<absolute-path-to-this-repo>/armory-electron-runtime-linux-x64/armory-electron-runtime --devtools --window ${width}x${height} ${dir}/debug/html5/index.html'`
```

If you want to have this permanently put it somewhere like `.zshrc` or `.bashrc`.  

Start blender and `Play` the `Browser` target.

The (X) window class name is `armory-electron-runtime` if you want to apply some custom settings.

For accessing the electron api from haxe add [hxelectron](https://github.com/tong/hxelectron) to your khaconfig.js:
```sh
project.addLibrary('electron');
```




### Logging
```sh
export ELECTRON_ENABLE_LOGGING=true
```

Supported environment variables: https://www.electronjs.org/docs/latest/api/environment-variables


### Flags

- `--devtools` Open devtools when application starts
- `--window ${width}x${height}` Window width, height

Supported electron command line switches: https://www.electronjs.org/docs/latest/api/command-line-switches

