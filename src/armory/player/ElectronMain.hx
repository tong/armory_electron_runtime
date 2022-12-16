package armory.player;

import electron.main.App;
import electron.main.BrowserWindow;
import js.Node.__dirname;
import js.Node.console;
import js.Node.process;
import js.node.Fs;

using StringTools;

class ElectronMain {

	static function main() {

        var path : String = null;
        var width = 960;
        var height = 540;
        var live = false;
        var devtools = false;
        
        var args = process.argv;
        path = args.pop();
        var i = 1;
        while(i < args.length) {
            trace(args[i]);
            switch args[i] {
            case '--live': live = true;
            case '--devtools': devtools = true;
            case '--window':
                var a = args[i+1].split("x");
                width = Std.parseInt(a[0]);
                height = Std.parseInt(a[1]);
            }
            i++;
        }
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
					nodeIntegration: true,
					contextIsolation: false,
					//enableRemoteModule: true
				}
			} );
			win.on( closed, function() {
				win = null;
			});
			win.setIcon(js.node.Path.join( __dirname, 'icon.png'));
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

}
