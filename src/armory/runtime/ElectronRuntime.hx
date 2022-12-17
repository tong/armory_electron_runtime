package armory.runtime;

import electron.main.App;
import electron.main.BrowserWindow;
import js.Node.__dirname;
import js.Node.console;
import js.Node.process;
import js.node.Path;
import js.node.Fs;

using StringTools;

function main() {

    var path : String = null;
    var width = 1280;
    var height = 720;
    var live = false;
    var devtools = false;
    var nodeIntegration = false;

    var args = process.argv;
    path = args.pop();
    var i = 1;
    while(i < args.length) {
        switch args[i] {
        case '--devtools': devtools = true;
        case '--live': live = true;
        case '--node': nodeIntegration = true;
        case '--window':
            var a = args[i+1].split("x");
            width = Std.parseInt(a[0]);
            height = Std.parseInt(a[1]);
        }
        i++;
    }
    path = Path.resolve(path);
    if(!Fs.existsSync(path)) {
        process.stderr.write('Application not found\n');
        process.exit(1);
    }

    /*
    if(!url.startsWith('http://')) {
        console.error('Invalid url: $url');
        Sys.exit(1);
    }
    */
    electron.main.App.on( ready, e -> {
        var win = new BrowserWindow( {
            width: width, height: height,
            autoHideMenuBar: true,
            webPreferences: {
                nodeIntegration: nodeIntegration,
                contextIsolation: false,
                //enableRemoteModule: true
            }
        } );
        win.on( closed, () -> {
            win = null;
        });
        win.setIcon(Path.join( __dirname, 'icon.png'));
        console.info('Loading: $path');
        win.loadFile(path);
        //win.loadURL(url);
        if(devtools) {
            win.webContents.openDevTools();
        }
    });

    electron.main.App.on( window_all_closed, e -> {
        if( process.platform != 'darwin' ) electron.main.App.quit();
    });
}

