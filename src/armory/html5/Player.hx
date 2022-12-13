package armory.html5;

import electron.main.App;
import electron.main.BrowserWindow;
import js.Node.__dirname;
import js.Node.console;
import js.Node.process;

using StringTools;

class Player {

	static function main() {
        //trace(process.cwd());
        var path = process.argv[process.argv.length-1];
        /*
        if(!url.startsWith('http://')) {
            console.error('Invalid url: $url');
            Sys.exit(1);
        }
        */
		electron.main.App.on( ready, e -> {
			var win = new BrowserWindow( {
                //width: 600, height: 960,
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
            console.info('Loading $path');
            win.loadFile(path);
            //win.loadURL(url);
			//win.webContents.openDevTools();
		});

		electron.main.App.on( window_all_closed, e -> {
			if( process.platform != 'darwin' ) electron.main.App.quit();
		});
	}

}
