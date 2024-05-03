package;

using StringTools;

typedef Song =
{
	var title:String;
	var artist:String;
	var album:String;

	var bpm:Float;
	var lyricsFile:String;
	var lyrics:LyricsFile;
	var path:String;
	var _version:Int;
	var _format:String;
	var _created:String;
}

/**

	typedef LyricsFile =
	{
	var language:String;
	var lyrics:Array<LyricsPart>;
	var translatedLyrics:Array<LyricsPart>;
	var _version:Int;
	var _format:String;
	var _created:String;
	}

	typedef LyricsPart =
	{
	var start:Float;
	@:optional var end:Float;
	var text:String;
	}

**/
class SongParser
{
	public static function parser(file:String, ?difficulty:String)
	{
		var song:Song = {
			title: "title",
			artist: "artist",
			album: "album",
			bpm: 0.0,
			lyricsFile: "lyricsFile",
			lyrics: {
				language: "language",
				lyrics: [],
				translatedLyrics: [],
				_version: 0,
				_format: "format",
				_created: "created",
			},
			_version: 0,
			_format: "format",
			_created: "created",
			path: "path",
		};
		var gameFolder = Client.gamefolder();
		var hasDifficulty = difficulty != null && difficulty != "";
		var songFolder = gameFolder + "/songs/" + file + "/";
		if (FileSystem.exists("assets/songs/" + file + "/") && FileSystem.isDirectory("assets/songs/" + file + "/"))
		{
			songFolder = "assets/songs/" + file + "/";
		}
		song.path = songFolder;
		if (!FileSystem.exists(songFolder + "difficulties/") || !FileSystem.isDirectory(songFolder + "difficulties/"))
		{
			FileSystem.createDirectory(songFolder + "difficulties/");
		}
		if (hasDifficulty)
		{
			songFolder += "difficulties/" + difficulty + ".json";
		}
		else
		{
			var diffs = FileSystem.readDirectory(songFolder + "difficulties/");
		}
		var metainfo = '';
		console.log("Song folder: " + songFolder);
		if (FileSystem.exists(songFolder + "metainfo.ini"))
		{
			metainfo = File.getContent(songFolder + "metainfo.ini");
			// parse
			var values = new Map();
			var lines = metainfo.split("\n");
			for (line in lines)
			{
				var parts = line.split("=");
				console.log(line);
				if (parts.length == 2)
				{
					console.log(parts[0] + " " + parts[1]);
					values.set(parts[0], parts[1]);
				}
			}
			var songValues = Reflect.fields(song);
			for (value in songValues)
			{
				if (values.exists(value))
				{
					console.log(value + " " + values.get(value));
					var val:Dynamic = values.get(value);
					var strVal = Std.string(val);
					if (strVal.startsWith("\""))
						val = strVal.substring(1, strVal.length - 2);
					if (value == "bpm")
						val = Std.parseFloat(val);
					Reflect.setField(song, value, val);
				}
			}
		}
		console.log(songFolder + song.lyricsFile);
		if (FileSystem.exists(songFolder + song.lyricsFile))
		{
			var lyrics = File.getContent(songFolder + song.lyricsFile);
			var lyricsParts = lyrics.split("\n");
			for (lyric in lyricsParts)
			{
				var parts = lyric.split(" ");
				if (parts.length > 1)
				{
					var lyricPart = {
						start: Std.parseFloat(parts.shift()),
						text: parts.join(" ")
					};
					song.lyrics.lyrics.push(lyricPart);
				}
			}
		}
		return song;
	}
}
