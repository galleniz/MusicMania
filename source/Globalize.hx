package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import utils.Console;

using StringTools;

class Globalize
{
	public static var console:Console = Console.get();
	public static var game:FlxGame;
	public static var curState:FlxState;

	public static function sprite(path:String):FlxSprite
	{
		return cast FlxG.state.add(new FlxSprite(0, 0, path));
	}

	public static function sound(path:String):FlxSound
	{
		if (path.endsWith(".mp3"))
		{
			path = path.substr(0, path.length - 4) + ".ogg";
		}
		return new FlxSound().loadEmbedded(path);
	}

	public static function quickPlay(path:String):FlxSound
	{
		return sound(path).play();
	}

	public static function text(x:Float, y:Float, text:String):FlxText
	{
		return cast FlxG.state.add(new FlxText(x, y, 0, text));
	}

	public static function loadGraphic(path:String) {}
}
