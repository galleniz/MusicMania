package;

class Client
{
	public static function init()
	{
		console.info("pingin server...");
		var first = Date.now().getTime();
		var http = new Http("https://www.google.com");
		http.request();
		http.onData = function(data)
		{
			var second = Date.now().getTime();

			console.info("owo respon: " + (second - first) + "ms");
		};
		http.onError = function(error)
		{
			console.error("uwu error: " + error);
		};
		http.request(false);
		step();
	}

	public static var logs:Array<String> = [];

	public static function pushLog(log:String)
	{
		logs.push(log);
	}

	public static function getDocsPath()
	{
		return 'c:/Users/' + Sys.environment().get("USERNAME") + '/Documents/';
	}

	public static function gamefolder()
	{
		return getDocsPath() + 'galleniz/MusicMania';
	}

	public static function initGameFolder()
	{
		var gamefolder = gamefolder();
		var JSON = haxe.Json;
		if (!FileSystem.exists(gamefolder))
		{
			FileSystem.createDirectory(gamefolder);
		}
		var necesaryFiles = [
			{
				name: 'songs',
				type: 'folder'
			},
			{
				name: 'songs.json',
				type: 'file',
				content: JSON.stringify({songs: []})
			},
			{
				name: 'settings.json',
				type: 'file',
				content: JSON.stringify({settings: {}})
			},
			{
				name: "songs.gitrepo",
				type: "file",
				content: JSON.stringify([
					{
						repositoryURL: 'https://localhost:65555',
						type: "json_return",
						autoDownload: false,
						cachePath: "cache/%DATE%.cach"
					}
				])
			},
			{
				name: "cache",
				type: "folder"
			},
			{
				name: "accounts.json",
				type: "file",
				content: JSON.stringify({
					accounts: {
						discord: {
							user: null
						},
						google: {
							user: null
						},
						twitter: {
							user: null
						},
						nvidiaShare: {
							user: null
						}
					}
				})
			},
			{
				name: "themes",
				type: "folder"
			},
			{
				name: "themes.json",
				type: "file",
				content: JSON.stringify({themes: []})
			},
			{
				name: "themes.gitrepo",
				type: "file",
				content: JSON.stringify([
					{
						repositoryURL: 'https://localhost:65555/themes',
						type: "json_return",
						autoDownload: false,
						cachePath: "cache/%DATE%.cach"
					}
				])
			},
			{
				name: "fonts",
				type: "folder"
			},
			{
				name: "editor.cache",
				type: "file",
				content: JSON.stringify({editor: []})
			},
			{
				name: ".env",
				type: 'file',
				content: 'test=false'
			}
		];
		for (i in necesaryFiles)
		{
			if (i.type == "file")
			{
				var path = i.name.split("/");
				var file = path.pop();
				var folder = path.join("/");
				if (folder != "")
					folder = gamefolder + "/" + folder + "/";
				else
					folder = gamefolder + "/";

				if (folder != "")
				{
					if (!FileSystem.exists(folder))
					{
						FileSystem.createDirectory(folder);
					}
				}
				var i:{name:String, type:String, content:String} = cast i;
				File.saveContent(folder + file, i.content);
			}
			else
			{
				if (!FileSystem.exists(gamefolder + "/" + i.name))
				{
					FileSystem.createDirectory(gamefolder + "/" + i.name);
				}
			}
		}
	}

	static function getCurLogFIle()
	{
		if (FileSystem.exists(gamefolder() + "/logs.txt"))
		{
			return File.getContent(gamefolder() + "/logs.txt");
		}
		return "";
	}

	public static function step()
	{
		while (true)
		{
			if (!FileSystem.exists(gamefolder() + "/songs.json"))
			{
				initGameFolder();
			}
			var dotlogsContent = getCurLogFIle();
			if (dotlogsContent != logs.join("\n"))
			{
				File.saveContent(gamefolder() + "/logs.txt", logs.join("\n"));
			}
			Sys.sleep(0.1);
		}
	}
}
