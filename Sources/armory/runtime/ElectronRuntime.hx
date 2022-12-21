package armory.runtime;

#if electron_main
import electron.main.App;
import electron.main.BrowserWindow;
import js.Node.__dirname;
import js.Node.console;
import js.Node.process;
import js.node.Path;
import js.node.Fs;

using StringTools;

function main() {
	var path:String = null;
	var width = 1280;
	var height = 720;
	var live = false;
	var fullscreen = false;
	var devtools = false;
	var nodeIntegration = false;

	var args = process.argv;
	path = args.pop();
	var i = 1;
	while (i < args.length) {
		switch args[i] {
			case '--devtools':
				devtools = true;
			case '--live':
				live = true;
			case '--fullscreen':
				fullscreen = true;
			case '--node':
				nodeIntegration = true;
			case '--window':
				var a = args[i + 1].split("x");
				width = Std.parseInt(a[0]);
				height = Std.parseInt(a[1]);
			case '--help':
		}
		i++;
	}
	path = Path.resolve(path);
	if (!Fs.existsSync(path)) {
		process.stderr.write('Application not found\n');
		process.exit(1);
	}

	/*
		if(!url.startsWith('http://')) {
			console.error('Invalid url: $url');
			Sys.exit(1);
		}
	 */

	electron.main.Menu.setApplicationMenu(null);
	electron.main.App.on(ready, e -> {
		var win = new BrowserWindow({
			width: width,
			height: height,
			autoHideMenuBar: true,
			fullscreen: fullscreen,
			webPreferences: {
				nodeIntegration: nodeIntegration,
				contextIsolation: false,
				// enableRemoteModule: true
			}
		});
		win.on(closed, () -> {
			win = null;
		});
		win.setIcon(Path.join(__dirname, 'icon.png'));
		console.info('Loading: $path');
		win.loadFile(path);
		// win.loadURL(url);
		if (devtools) {
			win.webContents.openDevTools();
		}
		/*
			var socket : Socket; 
			socket = js.node.Net.createConnection({port: 7001, host: "127.0.0.1"});
			socket.on(SocketEvent.Connect, () -> {
				trace("Socket connected");
				socket.write("Hello!\n");
			});
			socket = js.node.Net.createConnection({port: 7000}, () -> {
				trace('Connected');         
				socket.write('Hello\n');
			});
			socket.on(SocketEvent.Data, (data:Buffer) -> trace(data.toString()) );
			socket.on(SocketEvent.End, () -> trace("Disconnected") );
			socket.on(SocketEvent.Error, (e) -> trace("Socket error: "+e) );
		 */
	});
	electron.main.App.on(window_all_closed, e -> {
		if (process.platform != 'darwin')
			electron.main.App.quit();
	});
}
#end
