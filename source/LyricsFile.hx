package;

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
